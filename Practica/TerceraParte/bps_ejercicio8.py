#!/usr/bin/env python3

#  8. Crea una vista "Stock_Productos"que recoga la siguiente información: el identicador del item
# (ïtem_id"), la descripción del item ("description") y la cantidad de stock de ese item ("quantity"de
# la tabla stock) incluso de aquellos items de los que no hay stock


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
            CREATE VIEW Stock_Productos AS 
            SELECT s.item_id, i.description, s.quantity
            FROM stock as s
            LEFT JOIN item as i ON s.item_id = i.item_id
        '''

        with conn.cursor() as cur:
            cur.execute(query)
            print("Vista creada")
            conn.commit()
        # data = cur.execute(query)

        

        


        

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
    
