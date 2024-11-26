from fastapi import FastAPI
from app.views import api  # Asegúrate de que api.router esté correctamente configurado en tu proyecto
from fastapi.middleware.cors import CORSMiddleware
import os
from dotenv import load_dotenv

# Cargar variables de entorno desde el archivo .env
load_dotenv()

app = FastAPI()

# Verificar y cargar el archivo .env
dotenv_path = os.path.join(os.path.dirname(__file__), '.env')
if os.path.exists(dotenv_path):
    load_dotenv(dotenv_path)
    print(f"Archivo .env cargado desde {dotenv_path}")
else:
    print(f"Archivo .env no encontrado en {dotenv_path}")

# Configuración de CORS
origins = [
    "http://localhost",
    "http://localhost:8000",
    "http://localhost:60452/#/table",
    # Agrega aquí más orígenes permitidos si lo necesitas
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # Definir los orígenes permitidos
    allow_credentials=True,
    allow_methods=["*"],  # Permitir todos los métodos HTTP
    allow_headers=["*"],  # Permitir todos los headers
)

# Incluir las rutas del enrutador definido en app.views.api
app.include_router(api.router)

# Iniciar la aplicación utilizando uvicorn, leyendo host y port desde .env
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        app, 
        host=os.getenv("HOST"),  # Valor por defecto '127.0.0.1' si no está en .env
        port=int(os.getenv("PORT")),  # Valor por defecto 8000 si no está en .env
        reload=True  # Modo de recarga automática en desarrollo
    )
