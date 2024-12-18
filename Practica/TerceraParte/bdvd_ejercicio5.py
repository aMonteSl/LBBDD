#!/usr/bin/env python3

'''
5. Ejecuta una consulta compleja sobre la base de datos DVDRental para obtener todas las películas
junto con la cantidad de veces que han sido alquiladas. Mide cuánto tiempo tarda la consulta en
ejecutarse utilizando Python y psycopg. Usa el paquete ’time’ de Python para medir el tiempo de
la consulta
'''

import psycopg
import configparser
import time

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "DVDRENTAL"

    try:
        with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                            dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                            password=config.get(config_type, "Password")
            ) as conn:
            print("Conectado a la base de datos\n")
            with conn.cursor() as cur:
                # Consultar todas las películas junto con la cantidad de veces que han sido alquiladas
                start_time = time.time()
                cur.execute("SELECT film.title, COUNT(rental.rental_id) AS veces_alquilada FROM film "
                            "INNER JOIN inventory ON film.film_id = inventory.film_id "
                            "INNER JOIN rental ON inventory.inventory_id = rental.inventory_id "
                            "GROUP BY film.title")
                films = cur.fetchall()
                print(f"Películas junto con la cantidad de veces que han sido alquiladas: {films}\n")
                end_time = time.time()
                print(f"Tiempo de ejecución de la consulta: {end_time - start_time} segundos\n")

                

                return cur, conn

    except Exception as e:
        print(f"Error en la conexión: {e}")
        return None, None


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
    
