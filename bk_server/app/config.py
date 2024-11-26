import os
from dotenv import load_dotenv

# Cargar las variables del archivo .env
load_dotenv()

LDAP_SERVER = os.getenv("LDAP_SERVER")
SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = os.getenv("ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES","30"))
ADMIN_GROUP_DN = os.getenv("LDAP_ADMIN_GROUP_DN")
