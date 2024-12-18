#!/usr/bin/env python3

'''
4. Conéctate a la base de datos DVDRental como el usuario employee_user (usando un archivo de
configuración config.ini) y consulta los títulos de 5 películas de la tabla film para verificar que el
usuario tiene los permisos correctos.
'''

import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "DVDRENTALEMPLOYEE"

    try:
        with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                            dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                            password=config.get(config_type, "Password")
            ) as conn:
            print("Conectado a la base de datos\n")
            with conn.cursor() as cur:
                # Consultar los títulos de 5 películas de la tabla film
                cur.execute("SELECT title FROM film LIMIT 5")
                films = cur.fetchall()
                print(f"Títulos de 5 películas de la tabla film: {films}\n")
                

                return cur, conn

    except Exception as e:
        print(f"Error en la conexión: {e}")
        return None, None


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
    
