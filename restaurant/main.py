import pandas as pd
from sqlalchemy import create_engine

print("Sending data...")

connection = create_engine("mysql+pymysql://root:root@localhost:3306/db_restaurant")

empresa = pd.read_csv("tb_empresa.csv", sep=";")
funcionarios = pd.read_csv("tb_beneficio.csv", sep=";")

empresa.to_sql("tb_empresa", connection, index=False, if_exists="append")
funcionarios.to_sql("tb_beneficio", connection, index=False, if_exists="append")

print("Data sent to SQL successfully.")