#!/usr/bin/env python3

'''
2. Crea un rol llamado employee_role en la base de datos DVDRental. Este rol debe tener permisos
de solo lectura (SELECT) sobre la tabla film. No se usará directamente para conectarse a la base
de datos, sino que será asignado a usuarios que hereden sus permisos
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
                # Crear rol employee_role
                cur.execute("CREATE ROLE employee_role NOINHERIT LOGIN PASSWORD 'employee_role'")
                print("Rol employee_role creado\n")

                # Asignar permisos de solo lectura a la tabla film
                cur.execute("GRANT SELECT ON film TO employee_role")
                print("Permisos asignados a la tabla film\n")

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
    
