#!/usr/bin/env python3

'''
7. Realiza la inserción de datos en la tabla considerando que las publicaciones tienen los siguientes
autores, recuerda que solo necesitas insertar el id de la publicación y el id del profesor:
ID_Publicacion 1 (Avances en Medicina Preventiva):
• Profesores Asociados:
◦ Luis Martinez (IDProfesor: 2003)
◦ Juan Lopez (IDProfesor: 2001)
◦ Maria Garcia (IDProfesor: 2002)
ID_Publicacion 2 (Desarrollos en Inteligencia Artifcial):
• Profesores Asociados:
◦ Ana Rodriguez (IDProfesor: 2004)
◦ Miguel Perez (IDProfesor: 2007)
ID_Publicacion 3 (Estudios Sociológicos):
• Profesores Asociados:
◦ Maria Garcia (IDProfesor: 2002)
◦ Carlos Fernandez (IDProfesor: 2005)
◦ Isabel Sanchez (IDProfesor: 2008)
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
            INSERT INTO publicaciones_profesores(id_publicacion, idprofesor)
            VALUES
                (1, 2003),
                (1, 2001),
                (1, 2002),
                (2, 2004),
                (2, 2007),
                (3, 2002),
                (3, 2005),
                (3, 2008)
        '''

        
        data = cur.execute(query)

        print("Tabla creada")
        
        

            


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
    
