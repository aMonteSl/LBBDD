#!/usr/bin/env python3

'''
8. Consulta la lista de índices creados en la base de datos DVDRental para confirmar que el índice
idx_rental_inventory_id fue creado correctamente. La tabla de indices es ’pg_indexes’
5
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
                # Consultar la lista de índices creados en la base de datos DVDRental
                cur.execute("SELECT * FROM pg_indexes")
                indexes = cur.fetchall()
                # Si en indexes esta el índice idx_rental_inventory_id, entonces fue creado correctamente
                if any("idx_rental_inventory_id" in index for index in indexes):
                    print("Índice idx_rental_inventory_id fue creado correctamente\n")
                else:
                    print("Índice idx_rental_inventory_id no fue creado correctamente\n")


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
    
