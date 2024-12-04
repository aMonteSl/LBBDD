#!/usr/bin/env python3

'''
2. Crea una nueva tabla llamada "publicacion"que almacenará información sobre las publicaciones
de la universidad. La tabla debe tener los siguientes campos: id_publicación (serial, clave prima-
ria), título(cadena de caracteres de hasta 50 caracteres), tipo_publicacion (cadena de caracteres de
hasta 50 caracteres, en principio Revista o Congreso), Fecha_Publicación (date), Autores (integer)
y coste (numeric(8,2))

'''

import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "BPUNIVERSIDAD"
    count = 0


    with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                        dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                        password=config.get(config_type, "Password")
        ) as conn:
        print("Conectado a la base de datos\n")
        cur = conn.cursor()

        query = '''
            CREATE TABLE publicacion(
                id_publicacion SERIAL PRIMARY KEY,
                titulo VARCHAR(50),
                tipo_publicacion VARCHAR(50),
                fecha_publicacion DATE,
                autores INTEGER,
                coste NUMERIC(8,2)
            )
        '''

        
        data = cur.execute(query)
        print("Tabla creada")
        print(data)

        print(f"Total de registros: {count}")

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
    
