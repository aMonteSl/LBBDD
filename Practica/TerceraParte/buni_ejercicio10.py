#!/usr/bin/env python3

'''
10. Una vez eliminada la columna edad, generar una nueva columna en la tabla .estudiantesçon el
nombre "Fecha_Nacimiento". Creada la columna actualiza a todos los estudiantes con las siguien-
tes fechas de nacimiento:
Matrícula 1001: 1998-03-12
Matrícula 1002: 2000-07-22
Matrícula 1003: 2005-02-10
Matrícula 1004: 2003-11-05
Matrícula 1005: 1998-09-30
Matrícula 1006: 2002-01-18
Matrícula 1007: 2002-04-07
Matrícula 1008: 2001-06-14
Matrícula 1009: 2004-08-23
Matrícula 1010: 2003-10-11
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
            ALTER TABLE estudiantes
            ADD COLUMN fecha_nacimiento DATE
        '''
        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '1998-03-12'
            WHERE matricula = 1001
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2000-07-22'
            WHERE matricula = 1002
        '''
        
        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2005-02-10'
            WHERE matricula = 1003
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2003-11-05'
            WHERE matricula = 1004
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '1998-09-30'
            WHERE matricula = 1005
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2002-01-18'
            WHERE matricula = 1006
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2002-04-07'
            WHERE matricula = 1007
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2001-06-14'
            WHERE matricula = 1008
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2004-08-23'
            WHERE matricula = 1009
        '''

        data = cur.execute(query)

        query = '''
            UPDATE estudiantes
            SET fecha_nacimiento = '2003-10-11'
            WHERE matricula = 1010
        '''

        data = cur.execute(query)

        

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
    
