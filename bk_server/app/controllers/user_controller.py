import binascii
import os
from fastapi import HTTPException
from ldap3 import SUBTREE, MODIFY_REPLACE
# from app.config import ADMIN_GROUP_DN
from app.controllers.auth_controller import get_ldap_connection

# Verificar si el usuario pertenece al grupo de administradores
def is_user_in_admin_group(username: str, password: str):
    conn = get_ldap_connection(username, password)
    search_filter = f'(&(objectClass=user)(objectCategory=person)(sAMAccountName={username}))'
    conn.search(
        search_base='DC=DTPHS,DC=LOCAL',
        search_filter=search_filter,
        search_scope=SUBTREE,
        attributes=['memberOf']
    )
    
    if len(conn.entries) == 0:
        raise HTTPException(status_code=404, detail="User not found")

    entry = conn.entries[0]
    if hasattr(entry, 'memberOf'):
        member_of = entry.memberOf.values
        return os.getenv("ADMIN_GROUP_DN") in member_of
    return False
# Función para obtener todos los usuarios
def get_all_users(username: str, password: str):
    conn = get_ldap_connection(username, password)
    search_filter = '(&(objectClass=user)(objectCategory=person))'
    conn.search(
        search_base='DC=DTPHS,DC=LOCAL',
        search_filter=search_filter,
        search_scope=SUBTREE,
        attributes=['cn', 'sAMAccountName', 'userAccountControl']
    )
    
    users = []
    for entry in conn.entries:
        user_account_control = int(entry.userAccountControl.value)
        account_status = 'Disabled' if (user_account_control & 2) != 0 else 'Enabled'
        users.append({
            'fullname': entry.cn.value,
            'username': entry.sAMAccountName.value,
            'status': account_status
        })

    return users

# Crear un nuevo usuario en LDAP
def create_user(username: str, password: str, user_dn: str, user_attributes: dict):
    conn = get_ldap_connection(username, password)
    try:
        if conn.add(user_dn, attributes=user_attributes):
            new_password = '"ABCabc123"'.encode('utf-16-le')
            conn.extend.microsoft.modify_password(user_dn, new_password)
            conn.modify(user_dn, {'userAccountControl': [(MODIFY_REPLACE, [512])]})
            conn.modify(user_dn, {'pwdLastSet': [(MODIFY_REPLACE, [0])]})
            return True
        return False
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error creating user: {str(e)}")

# def get_all_users_with_ssid(username: str, password: str):
#     conn = get_ldap_connection(username, password)
#     search_filter = '(&(objectClass=user)(objectCategory=person))'
    
#     conn.search(
#         search_base='DC=DTPHS,DC=LOCAL',
#         search_filter=search_filter,
#         search_scope=SUBTREE,
#         attributes=['cn', 'sAMAccountName', 'objectSid', 'userAccountControl']
#     )

#     users = []
#     for entry in conn.entries:
#         user_account_control = int(entry.userAccountControl.value)
#         account_status = 'Disabled' if (user_account_control & 2) != 0 else 'Enabled'
        
#         users.append({
#             'fullname': entry.cn.value,
#             'username': entry.sAMAccountName.value,
#             'ssid': str(entry.objectSid.value),  # Convertir el SID a string
#             'status': account_status
#         })

#     if not users:
#         raise HTTPException(status_code=404, detail="No users found")

#     return users

# def get_user_ssid(target_username: str, admin_username: str, admin_password: str):
#     conn = get_ldap_connection(admin_username, admin_password)
    
#     # Filtro LDAP para buscar al usuario específico
#     search_filter = f'(&(objectClass=user)(objectCategory=person)(sAMAccountName={target_username}))'
    
#     conn.search(
#         search_base='DC=DTPHS,DC=LOCAL',
#         search_filter=search_filter,
#         search_scope=SUBTREE,
#         attributes=['cn', 'sAMAccountName', 'objectSid']
#     )

#     if not conn.entries:
#         return None

#     entry = conn.entries[0]  # Asumiendo que solo hay un usuario con ese sAMAccountName

#     return {
#         'fullname': entry.cn.value,
#         'username': entry.sAMAccountName.value,
#         'ssid': str(entry.objectSid.value)  # Convertir el SID a string
#     }

def sid_to_hex_with_prefix(sid: str) -> str:
    """
    Convierte un SID en formato S-1-... a su representación hexadecimal con prefijo 0x.
    """
    # Separar los componentes del SID por los guiones
    parts = sid.split('-')

    # Validar que el SID comience con 'S'
    if parts[0] != 'S':
        raise ValueError("El SID debe empezar con 'S'.")

    # Convertir la revisión (segunda parte del SID) a un byte
    revision = int(parts[1])
    revision_byte = revision.to_bytes(1, byteorder='little')

    # Número de subautoridades (el resto de los segmentos)
    num_subauthorities = len(parts[3:]).to_bytes(1, byteorder='little')

    # Autoridad del identificador (tercera parte del SID) como 6 bytes en big-endian
    authority = int(parts[2])
    authority_bytes = authority.to_bytes(6, byteorder='big')

    # Subautoridades en formato little-endian (cada una 4 bytes)
    subauthorities = b''.join(
        int(sub).to_bytes(4, byteorder='little') for sub in parts[3:]
    )

    # Concatenar todos los bytes
    sid_bytes = revision_byte + num_subauthorities + authority_bytes + subauthorities

    # Convertir los bytes a una cadena hexadecimal con prefijo 0x
    hex_string = "0x" + sid_bytes.hex().upper()

    # Imprimir el resultado para verificación
    print(f"SID en binario: {sid_bytes}")
    print(f"SID en hexadecimal: {hex_string}")

    return hex_string
def sid_to_varbinary(sid: str) -> bytes:
    """
    Convierte un SID proporcionado como string a su representación VARBINARY para SQL Server.
    """
    # Elimina espacios en blanco y guiones del SID
    sid = sid.strip().replace('-', '')

    # Verifica que solo contenga caracteres hexadecimales
    if not all(c in '0123456789ABCDEFabcdef' for c in sid):
        raise ValueError("El SID contiene caracteres no hexadecimales.")

    # Intenta convertir el SID a bytes (varbinary)
    try:
        return bytes.fromhex(sid)
    except ValueError as e:
        raise ValueError(f"Error al convertir el SID a varbinary: {e}")


def get_user_sid(target_username: str, admin_username: str, admin_password: str) -> str:
    """
    Obtiene el SID del usuario específico desde el Active Directory.
    """
    conn = get_ldap_connection(admin_username, admin_password)
    
    search_filter = f'(&(objectClass=user)(objectCategory=person)(sAMAccountName={target_username}))'
    
    conn.search(
        search_base='DC=DTPHS,DC=LOCAL',
        search_filter=search_filter,
        search_scope=SUBTREE,
        attributes=['objectSid']
    )

    if not conn.entries:
        raise Exception(f"User '{target_username}' not found")

    # Obtiene el SID en formato binario
    sid_binary = conn.entries[0].objectSid.value

    # Convierte el SID a formato hexadecimal
    sid_hex = sid_to_hex_with_prefix(sid_binary)

    return sid_hex