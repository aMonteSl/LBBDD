#!/usr/bin/env python3

#  7. continuación, comprueba que se ha actualizado correctamente la tabla .orderinfo". Para ello,
# genera una consulta que recoga el identificador de orderinfo (.orderinfo_id"), el identificador
# del cliente que realizó el pedido (çustomer_id"), el nombre y apellido del cliente ("fname", "lna-
# me") y, por último, el identificador, el nombre y el apellido del empleado (.employee_id", "name",
# "last_name") que gestionó el pedido


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
            SELECT o.orderinfo_id, o.customer_id, c.fname, c.lname, e.employee_id, e.name, e.last_name
            FROM orderinfo AS o
            JOIN customer as c ON o.customer_id = c.customer_id
            JOIN employees AS e ON o.employee_id = e.employee_id

        '''


        data = cur.execute(query)

        for row in data:
            print(f"El cliente: {row[2]} {row[3]} con id {row[1]} hizo el pedido {row[0]} gestionado por el empleado {row[5]} {row[6]} con id {row[4]}\n")

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
    
