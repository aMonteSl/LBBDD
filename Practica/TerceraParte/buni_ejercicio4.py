#!/usr/bin/env python3

'''
4. A continuación, comprueba que se ha generado correctamente la tabla "publicacion 2 que se han
introducido correctamente todos los datos generando una consulta que devuelva toda la informa-
ción de la tabla "publicacion
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
            SELECT * FROM publicacion
        '''

        
        data = cur.execute(query)
        print("Tabla creada")
        
        for row in data:
            print(row)
            


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
    
