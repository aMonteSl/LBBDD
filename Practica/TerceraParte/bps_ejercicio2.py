#!/usr/bin/env python3

# 2. Crea una nueva tabla llamada .employees"que almacenará información sobre los empleados de
# la empresa. La tabla debe tener los siguientes campos: employee_id (serial, clave primaria), na-
# me(cadena de caracteres de hasta 50 caracteres), last_name (cadena de caracteres de hasta 50 ca-
# racteres), start_date (date), salary(numeric(8,2))


import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "BPSIMPLE"


    with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                        dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                        password=config.get(config_type, "Password")
        ) as conn:
        print("Conectado a la base de datos")
        cur = conn.cursor()

        query = '''
            CREATE TABLE employees (
                employee_id SERIAL PRIMARY KEY,
                name VARCHAR(50),
                last_name VARCHAR(50),
                start_date DATE,
                salary NUMERIC(8,2)
            )
        '''

        data = cur.execute(query)
        print("Tabla creada")
        print(data)
        

    return cur, conn


if __name__ == "__main__":
    try:
        cur, conn = connect_postgres()

        if conn is not None:
            conn.close()
            print("Conexión cerrada")

        if cur is not None:
            cur.close()
            print("Cursor cerrado")


    except Exception as e:  
        print(f"Error en la conexión: {e}")
    
