#!/usr/bin/env python3

# 6. Inserta(ACTUALIZAR) la información de los empleados encargados de gestionar cada pedido en la tabla .orderinfo".
# Los datos son los siguientes:
# Orderinfo 1: Empleado 2.
# Orderinfo 2: Empleado 3.
# Orderinfo 3: Empleado 3.
# Orderinfo 4: Empleado 1.
# Orderinfo 5: Empleado 3.


import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "BPSIMPLE"


    with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                        dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                        password=config.get(config_type, "Password")
        ) as conn:
        print("Conectado a la base de datos\n")
        cur = conn.cursor()

        query = '''
            UPDATE orderinfo
            SET employee_id = 3
            WHERE orderinfo_id = 5

        '''

        data = cur.execute(query)

        print("Columna añadida")

        


        

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
    
