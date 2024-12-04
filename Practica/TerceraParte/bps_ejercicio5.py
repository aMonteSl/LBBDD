#!/usr/bin/env python3

# 5. Al añadir empleados a la base de datos, se desea registrar que empleado gestionó cada orden
# de pedido .orderinfo". Para ello, modifica la tabla .orderinfo.añadiendo una nuevo columna con el
# campo .employee_id"que será un entero que represente el identificador del empleado que gestionó
# la orden de pedido. 


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
            ALTER TABLE orderinfo
            ADD COLUMN employee_id INTEGER
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
    
