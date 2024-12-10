#!/usr/bin/env python3

'''
8. Para comprobar que todo es correcto, realiza una consulta a través de python que muestre el
nombre del departamento, el nombre y apellido del profesor junto con el título de la publicación
y su fecha de publicación
'''

import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "BPUNIVERSIDAD"



    with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                        dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                        password=config.get(config_type, "Password")
        ) as conn:
        print("Conectado a la base de datos\n")
        cur = conn.cursor()

        query = '''
            SELECT d.nombre, p.nombre, p.apellido, pu.titulo, pu.fecha_publicacion
            FROM departamentos d
            JOIN profesores p ON d.iddepartamento = p.iddepartamento
            JOIN publicaciones_profesores pp ON p.idprofesor = pp.idprofesor
            JOIN publicaciones pu ON pp.id_publicacion = pu.id_publicacion
        '''

        
        data = cur.execute(query)

        for row in cur.fetchall():
            print(row)
        
        

            


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
    
