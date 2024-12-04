#!/usr/bin/env python3

'''
6. Se quiere actualizar la base de datos para poder tener una relación entre los profesores y las publi-
caciones. Cómo esta relación es de cardinalidad N:N, es decir, una publicación puede estar hecha
por varios profesores y, cada profesor puede tener varias publicaciones, es necesario crear una
nueva tabla que relaciona Publicacion-Profesor. Por todo ello, crea, a través de Python, una nue-
va tabla llamada "Publicaciones_Profesores"que tenga como campos Id_publicacion(INTEGER y
clave primaria) y un idprofesor(INTEGER y clave Primaria). No es necesario especicar que son
claves foráneas, simplemente crear los dos campos y, en la sentencia de CREATE TABLE... aña-
dir al nal la siguiente instrucción PRIMARY KEY (id_publicacion, idprofesor)
'''

import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "BPUNIVERSIDAD"



    with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                        dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                        password=config.get(config_type, "Password")
        ) as conn:
        print("Conectado a la base de datos\n")
        cur = conn.cursor()

        query = '''
            CREATE TABLE publicaciones_profesores(
                id_publicacion INTEGER PRIMARY KEY,
                idprofesor INTEGER PRIMARY KEY
            )
            
        '''

        
        data = cur.execute(query)

        print("Tabla creada")
        
        

            


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
    
