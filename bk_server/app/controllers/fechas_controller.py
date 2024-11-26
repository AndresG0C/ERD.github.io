from datetime import datetime
from app.database import get_db_connection

def consultar_fechas(anio: int, mes: int):
    try:
        connection = get_db_connection()
        cursor = connection.cursor()
        
        # Llamada al procedimiento almacenado con los parámetros de año y mes
        cursor.execute("{CALL dbo.consultaFechas(?, ?)}", (anio, mes))
        
        # Si el procedimiento devuelve resultados, puedes utilizar fetchall()
        result = cursor.fetchall()
        
        # Verifica si hay resultados
        if not result:
            return []

        # Obtener los nombres de las columnas
        columns = [column[0] for column in cursor.description]

        # Convierte cada fila en un diccionario
        result_dicts = [dict(zip(columns, row)) for row in result]

        print(result_dicts)
        
        # Cerrar cursor y conexión
        cursor.close()
        connection.close()
        
        return result_dicts
    
    except Exception as e:
        print(f"Error al ejecutar el procedimiento almacenado: {e}")
        return None
