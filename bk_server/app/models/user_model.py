from pydantic import BaseModel


class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: str | None = None
    password: str | None = None

# Modelo de login
class LoginModel(BaseModel):
    username: str
    password: str

# Modelo para crear usuario
class UserCreateModel(BaseModel):
    fullname: str
    username: str
    # password: str
    

# Modelo de respuesta para listar usuarios
class UserResponseModel(BaseModel):
    fullname: str
    username: str
    status: str