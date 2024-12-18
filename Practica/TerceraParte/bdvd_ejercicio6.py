#!/usr/bin/env python3

'''
6. Crea un índice sobre la tabla rental en la columna inventory_id para optimizar la consulta utiliza-
da en el ejercicio anterior.
'''

import psycopg
import configparser


def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "DVDRENTAL"

    try:
        with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                            dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                            password=config.get(config_type, "Password")
            ) as conn:
            print("Conectado a la base de datos\n")
            with conn.cursor() as cur:
                # Crear un índice sobre la tabla rental en la columna inventory_id
                cur.execute("CREATE INDEX idx_inventory_id ON rental(inventory_id)")
                print("Índice creado en la tabla rental en la columna inventory_id\n")
                

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
    
