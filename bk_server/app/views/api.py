from fastapi import APIRouter, Depends, HTTPException
from app.controllers.auth_controller import authenticate_user, get_current_user
from app.controllers.fechas_controller import consultar_fechas
from app.controllers.user_controller import get_all_users, create_user, get_user_sid, is_user_in_admin_group
from app.database import get_db_connection
from app.models.user_model import LoginModel, Token, UserCreateModel
from app.jwt_handler import create_access_token
from datetime import datetime, timedelta

router = APIRouter()

@router.post("/login", response_model=Token)
async def login(form_data: LoginModel):
    conn = authenticate_user(form_data.username, form_data.password)
    access_token_expires = timedelta(minutes=30)
    access_token = create_access_token(
        data={"sub": form_data.username, "password": form_data.password}, 
        expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

@router.get("/users")
async def read_users(current_user=Depends(get_current_user)):
    # Verificar si el usuario está en el grupo de administradores
    if not is_user_in_admin_group(current_user.username, current_user.password):
        raise HTTPException(status_code=403, detail="You don't have permission to view users")

    # Si es administrador, traer los usuarios
    users = get_all_users(current_user.username, current_user.password)
    return users

# @router.post("/createuser")
# async def create_new_user(user: UserCreateModel, current_user=Depends(get_current_user)):
#     # Verificar si el usuario actual es administrador
#     if not is_user_in_admin_group(current_user.username, current_user.password):
#         raise HTTPException(status_code=403, detail="Access denied: User is not in the Administrators group")

#     user_dn = f"CN={user.fullname},OU=usuariosapp,DC=DTPHS,DC=LOCAL"
#     user_attributes = {
#         'objectClass': ['top', 'person', 'organizationalPerson', 'user'],
#         'cn': user.fullname,
#         'sAMAccountName': user.username,
#         'userPrincipalName': f"{user.username}@dtphs.local",
#         'displayName': user.fullname,
#         'givenName': user.fullname.split()[0],
#         'sn': user.fullname.split()[-1],
#         'userAccountControl': '544',
#     }

#     create_user(current_user.username, current_user.password, user_dn, user_attributes)
#     return {"message": f"User {user.fullname} created successfully"}

from fastapi import HTTPException
from datetime import datetime

@router.post("/createuser")
async def create_new_user(
    user: UserCreateModel, 
    current_user=Depends(get_current_user)
):
    # Verificar si el usuario es administrador
    if not is_user_in_admin_group(current_user.username, current_user.password):
        raise HTTPException(status_code=403, detail="Access denied: User is not in the Administrators group")

    user_dn = f"CN={user.fullname},OU=usuariosapp,DC=DTPHS,DC=LOCAL"
    user_attributes = {
        'objectClass': ['top', 'person', 'organizationalPerson', 'user'],
        'cn': user.fullname,
        'sAMAccountName': user.username,
        'userPrincipalName': f"{user.username}@dtphs.local",
        'displayName': user.fullname,
        'givenName': user.fullname.split()[0],
        'sn': user.fullname.split()[-1],
        'userAccountControl': '544',
    }

    # Validar si el usuario ya existe en Active Directory
    try:
        existing_sid = get_user_sid(user.username, current_user.username, current_user.password)
        if existing_sid:
            raise HTTPException(
                status_code=400, 
                detail=f"El usuario '{user.username}' ya existe en el sistema."
            )
    except Exception as e:
        # Si no encuentra el usuario, continuamos con la creación
        if "not found" not in str(e).lower():
            raise HTTPException(status_code=500, detail=f"Error al validar usuario: {str(e)}")

    # Intentar crear el usuario en Active Directory
    try:
        create_user(
            current_user.username, 
            current_user.password, 
            user_dn, 
            user_attributes
        )

        # Obtener el SID del usuario creado
        sid = get_user_sid(user.username, current_user.username, current_user.password)
        print(f"SID obtenido: {sid}")

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error en Active Directory: {str(e)}")

    # Preparar fechas actuales del sistema
    fecha_actual = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"Fecha actual: {fecha_actual}")

    


    # Si la creación en Active Directory fue exitosa, registrar en la base de datos
    try:
        connection = get_db_connection()
        cursor = connection.cursor()

        cursor.execute(
            """
            EXEC unoee.dbo.sp_usuario_adicionar 
                @p_nombre=?, 
                @p_path=?, 
                @p_sid=?, 
                @p_esgrupo=0, 
                @p_esactivo=1, 
                @p_cambiar=1, 
                @p_clave=N'82/TiCGioSWhQjlOP3SBxg==', 
                @p_descripcion=?, 
                @p_clave_net=N' ', 
                @p_rowid_politica=1, 
                @p_ind_bloqueado=0, 
                @p_fecha_asignacion_clave=?, 
                @p_correo_electronico=N'', 
                @p_ind_estado=1, 
                @p_fecha_ini_vigencia=?, 
                @p_fecha_fin_vigencia=NULL, 
                @p_rowid_usuario_sust=NULL, 
                @p_fecha_caducidad_sust=NULL, 
                @p_ind_perm_login_base=0, 
                @p_ind_programacion=0, 
                @p_ind_todo_lunes=0, 
                @p_ind_todo_martes=0, 
                @p_ind_todo_miercoles=0, 
                @p_ind_todo_jueves=0, 
                @p_ind_todo_viernes=0, 
                @p_ind_todo_sabado=0, 
                @p_ind_todo_domingo=0, 
                @p_usuario=N'', 
                @p_notas=N'', 
                @p_rowid=NULL
            """,
            (
                user.fullname, 
                f"LDAP://DTPHS.LOCAL/{user_dn}", 
                sid, 
                user.fullname, 
                fecha_actual, 
                fecha_actual
            )
        )

        connection.commit()
        cursor.close()
        connection.close()

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al crear usuario en la base de datos: {str(e)}")

    return {"message": f"Usuario {user.username} creado exitosamente", "sid": sid}


@router.get("/consultar_fechas")
async def consultar_fechas_endpoint(anio: int, mes: int):
    try:
        # Llamar a la función consultar_fechas con los parámetros anio y mes
        result = consultar_fechas(anio, mes)

        if result is None:
            raise HTTPException(status_code=500, detail="Error al ejecutar el procedimiento almacenado")

        # Verificar si no se encontraron registros
        if len(result) == 0:
            raise HTTPException(status_code=404, detail="No se encontraron registros para los parámetros proporcionados")

        return result

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# @router.get("/users_ssid")
# async def read_users_ssid(current_user=Depends(get_current_user)):
#     # Verificar si el usuario está en el grupo de administradores
#     if not is_user_in_admin_group(current_user.username, current_user.password):
#         raise HTTPException(status_code=403, detail="You don't have permission to view users")

#     try:
#         # Obtener la lista de usuarios con SSID
#         users = get_all_users_with_ssid(current_user.username, current_user.password)

#         if not users:
#             raise HTTPException(status_code=404, detail="No users found")

#         return users

#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))

# @router.get("/user_ssid")
# async def read_user_ssid(
#     username: str, 
#     current_user=Depends(get_current_user)
# ):
#     # Verificar si el usuario está en el grupo de administradores
#     if not is_user_in_admin_group(current_user.username, current_user.password):
#         raise HTTPException(status_code=403, detail="You don't have permission to view this user")

#     try:
#         # Obtener el SSID del usuario específico
#         user = get_user_ssid(username, current_user.username, current_user.password)

#         if not user:
#             raise HTTPException(status_code=404, detail=f"User '{username}' not found")

#         return user

#     except Exception as e:
#         raise HTTPException(status_code=500, detail=str(e))
    
    