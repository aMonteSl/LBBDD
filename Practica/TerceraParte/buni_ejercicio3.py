#!/usr/bin/env python3

'''
3. Introduce información para cinco publicaciones, proporcionando valores para los campos título,
tipo_publicación, Fecha_publicacion, autores y coste:
Publicación 1:
• Título: Avances en Medicina Preventiva
• Tipo de Publicación: Revista
• Fecha de Publicación: 2023-01-15
• Autores: 3
• Coste: 1500.00 €
Publicación 2:
• Título: Desarrollos en Inteligencia Articial
• Tipo de Publicación: Congreso
• Fecha de Publicación: 2023-02-01
• Autores: 5
• Coste: 500.00 €
Publicación 3:
• Título: Estudios Sociológicos
• Tipo de Publicación: Revista
• Fecha de Publicación: 2023-03-10
• Autores: 4
• Coste: 1800.00 €
Publicación 4:
• Título: Innovaciones en Ingeniería de Software
• Tipo de Publicación: Congreso
• Fecha de Publicación: 2023-04-05
• Autores: 5
• Coste: 420.00 €
Publicación 5:
• Título: Avances en Neurociencia
• Tipo de Publicación: Revista
• Fecha de Publicación: 2023-04-01
• Autores: 5
• Coste: 2000.00 €
'''

import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "BPUNIVERSIDAD"
    count = 0


    with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                        dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                        password=config.get(config_type, "Password")
        ) as conn:
        print("Conectado a la base de datos\n")
        cur = conn.cursor()

        query = '''
            INSERT INTO publicacion(titulo, tipo_publicacion, fecha_publicacion, autores, coste)
            VALUES
                ('Avances en Medicina Preventiva', 'Revista', '2023-01-15', 3, 1500.00),
                ('Desarrollos en Inteligencia Artificial', 'Congreso', '2023-02-01', 5, 500.00),
                ('Estudios Sociológicos', 'Revista', '2023-03-10', 4, 1800.00),
                ('Innovaciones en Ingeniería de Software', 'Congreso', '2023-04-05', 5, 420.00),
                ('Avances en Neurociencia', 'Revista', '2023-04-01', 5, 2000.00)
        '''

        
        data = cur.execute(query)
        print("Tabla creada")
        print(data)

        print(f"Total de registros: {count}")

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
    
