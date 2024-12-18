#!/usr/bin/env python3

'''
3. Crea un usuario llamado employee_user en la base de datos DVDRental. Este usuario hereda-
rá los permisos del rol employee_role y podrá conectarse a la base de datos con la contraseña
securepassword123
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
                # Crear usuario employee_user
                cur.execute("CREATE USER employee_user WITH PASSWORD 'securepassword123'")
                print("Usuario employee_user creado\n")

                # Asignar rol employee_role al usuario employee_user
                cur.execute("GRANT employee_role TO employee_user")
                print("Rol employee_role asignado al usuario employee_user\n")

                # Mostrar los roles asignados al usuario employee_user
                cur.execute("SELECT rolname FROM pg_roles WHERE rolname = 'employee_user'")
                roles = cur.fetchall()
                print(f"Roles asignados al usuario employee_user: {roles}\n")
                

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
    
