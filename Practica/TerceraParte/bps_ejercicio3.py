#!/usr/bin/env python3

# 3. Introduce información para tres empleados, proporcionando valores para los campos name, last_name,
# start_date, y salary:
# Empleado 1:
# • Nombre: William
# • Apellidos: Turner
# • Fecha de Incorporación: 2003-01-15
# • Salario: 40000.00
# Empleado 2:
# • Nombre: Charlotte
# • Apellidos: Anderson
# • Fecha de Incorporación: 2003-02-01
# • Salario: 50000.00
# Empleado 3:
# • Nombre: James
# • Apellidos: Parker
# • Fecha de Incorporación: 2003-03-10
# • Salario: 40000.00


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
        print("Conectado a la base de datos")
        cur = conn.cursor()

        query = '''
            INSERT INTO employees (name, last_name, start_date, salary)
            VALUES ('William', 'Turner', '2003-01-15', 40000.00),
            ('Charlotte', 'Anderson', '2003-02-01', 50000.00),
            ('James', 'Parker', '2003-03-10', 40000.00)
        '''


        data = cur.execute(query)
        print("Tabla creada")
        print(data)

        query = "SELECT * FROM employees"
        data = cur.execute(query)
        for row in data:
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
    
