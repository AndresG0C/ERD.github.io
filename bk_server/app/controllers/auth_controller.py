import os
from fastapi import HTTPException, Depends, Request, status
from app.jwt_handler import create_access_token, verify_token
from app.models.user_model import TokenData
from ldap3 import Server, Connection, ALL
from app.config import LDAP_SERVER

# Función para conectar al servidor LDAP
def get_ldap_connection(username: str, password: str):
    LDAP_USERNAME = f'{username}@DTPHS.LOCAL'
    try:
        server = Server(os.getenv("LDAP_SERVER"), get_info=ALL, use_ssl=True)
        conn = Connection(server, user=LDAP_USERNAME, password=password, auto_bind=True)
        return conn
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error connecting to LDAP: {e}")

# Autenticar el usuario contra el servidor LDAP
def authenticate_user(username: str, password: str):
    conn = get_ldap_connection(username, password)
    if not conn.bind():
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return conn

# Obtener el usuario actual desde el token JWT
async def get_current_user(request: Request):
    authorization: str = request.headers.get("Authorization")
    if authorization is None or not authorization.startswith("Bearer "):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Bearer token missing",
            headers={"WWW-Authenticate": "Bearer"},
        )

    token = authorization.split(" ")[1]
    return verify_token(token)
