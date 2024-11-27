import psycopg
import configparser

def connect_postgres():
    config = configparser.ConfigParser() # Estancia de la clase ConfigParser
    config.read("config.ini") # Lee el archivo config.ini
    config_type = "DVDRENTAL"

    with psycopg.connect(host=config.get(config_type, "Host"), port=config.get(config_type, "Port"), 
                        dbname=config.get(config_type, "Dbname"), user=config.get(config_type, "User"),
                        password=config.get(config_type, "Password")
        ) as conn:
        print("Conectado a la base de datos")
        cur = conn.cursor()

        data = cur.execute("SELECT * FROM film")
        for row in data:
            print(row)

    return cur, conn


if __name__ == "__main__":
    try:
        cur, conn = connect_postgres()

        

    except Exception as e:  
        print(f"Error en la conexión: {e}")
    
