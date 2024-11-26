from datetime import datetime, timedelta
import os
from jose import jwt, JWTError
from fastapi import HTTPException, status
from typing import Optional
from app.models.user_model import TokenData
from app.config import SECRET_KEY, ALGORITHM

# Función para generar el token de acceso
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, os.getenv("SECRET_KEY"), algorithm=os.getenv("ALGORITHM"))
    return encoded_jwt

# Función para decodificar y verificar el token JWT
def verify_token(token: str):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    try:
        payload = jwt.decode(token, os.getenv("SECRET_KEY"), algorithms=[os.getenv("ALGORITHM")])
        username: str = payload.get("sub")
        password: str = payload.get("password")
        if username is None or password is None:
            raise credentials_exception
        return TokenData(username=username, password=password)
    except JWTError:
        raise credentials_exception
