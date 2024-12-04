#!/usr/bin/env python3

'''
1. Elabora un script en Python üniversidad.py"que gestione la conexión a la base de datos univer-
sidad. El Script deberá permitir la conexión a la base de datos mediante el uso de un archivo de
conguración çong.ini", gestionar posibles errores de conexión y terminar cerrando la conexión.
A partir del script creado para garantizar la conexión a la base de datos universidad, realiza las
siguientes acciones:

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
            SELECT * FROM estudiantes
        '''

        
        data = cur.execute(query)

        for row in data:
            print(row)
            count += 1

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
    
