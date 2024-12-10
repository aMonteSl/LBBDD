#!/usr/bin/env python3

'''
11. Para comprobar que la actualziación de esta tabla ha sido satisfactoria, genera una consulta que
devuelva la matricula, nombre, apellido y edad (pero calculada a partir de la fecha de nacimiento),
de cada estudiante. (Muestra la edad en años).
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
            SELECT matricula, nombre, apellido, DATE_PART('year', AGE(fecha_nacimiento)) as edad
            FROM estudiantes
        '''

        
        data = cur.execute(query)

        for row in cur.fetchall():
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
    
