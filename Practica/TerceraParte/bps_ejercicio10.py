#!/usr/bin/env python3

# 10. Debido a un defecto de fábrica se deben retirar todos los productos del item_id 4 del stock. Por
# tanto, lleva a cabo la eliminación de este registro de la tabla stock. Tras borrar el registro corres-
# pondiente, comprueba que todo es correcto utilizando la vista creada en el apartado 8


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

        # Tengo qeu borrar el registro del item_id 4 de la tabla stock y luego comprobar que todo es correcto

        # Primero elimino el registro de la tabla stock
        query = '''
            DELETE FROM stock
            WHERE item_id = 4
        '''

        with conn.cursor() as cur:
            cur.execute(query)
            print("Registro eliminado")
            conn.commit()

        # Compruebo que todo es correcto utilizando la vista creada en el apartado 8
        query = '''
            SELECT * FROM Stock_Productos
        '''

        with conn.cursor() as cur:
            cur.execute(query)
            data = cur.fetchall()
            print(data)
            conn.commit()
    

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
    
