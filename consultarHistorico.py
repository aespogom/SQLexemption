import logging
import re
import sqlalchemy
import azure.functions as func
import json
import pandas as pd
from datetime import date

today = date.today()

import os

Driver = os.environ["DRIVER"]
logging.info(Driver)
Server = os.environ["SERVER"]
Port = os.environ["PORT"]
Database = os.environ["DATABASE"]
Uid = os.environ["UID"]
Pwd = os.environ["PWD"]
Tabla = os.environ["TABLA_ENSAYOS_2"]
Tabla_formulas_terminadas = os.environ["TABLA_FORMULAS"]
Tabla_formulas_sin_terminadas = os.environ["TABLA_FORMULAS_INACABADAS"]

def consultar_historico(req_body):
    
    informe = req_body.get('informe')
    nombre_ensayo = req_body.get('nombre_ensayo')
    fecha_from = req_body.get('fecha_from')
    fecha_to = req_body.get('fecha_to')
    idp = req_body.get('idp')
    categoria = req_body.get('selected_categoria') #PArte formulas
    set_manchas = req_body.get('selected_mancha')
    analista = req_body.get('analista') 
    temperatura = req_body.get('temperatura')
    lavadora = req_body.get('selected_lavadora')
    instrumento = req_body.get('selected_instrumento')
    nombre_formula = req_body.get('nombre_formula') #PArte formulas
    metodo = req_body.get('metodo')


    engine = sqlalchemy.create_engine(f'mssql+pyodbc://{Uid}:{Pwd}@{Server}:{str(Port)}/{Database}?driver={Driver}', echo = True)
   
    query = (f' {metodo}  * FROM  {Tabla}') 

    if fecha_from and fecha_to:
        query = (f"{query} WHERE fecha BETWEEN '{fecha_from}' AND '{fecha_to}'")        
    elif not fecha_to and fecha_from:
        query = (f"{query} WHERE fecha >= '{fecha_from}'") 
    elif not fecha_from and fecha_to:
        query = (f"{query} WHERE fecha <= '{fecha_from}'") 
    logging.info('despues fecha')
    logging.info(query)

    if idp:
        if 'WHERE' in query:
            query = (f"{query} AND idp{idp}")
        else:
            query = (f"{query} WHERE idp{idp}")
    
    logging.info('despues idp')
    logging.info(query)

    if analista:
         if 'WHERE' in query:
             query = (f"{query}  AND analista{analista}")
         else:
             query = (f"{query}  WHERE analista{analista}")
    logging.info('despues analista')
    logging.info(query)

    if informe:
        if 'WHERE' in query:
            query = (f"{query}  AND informe{informe}")
        else:
            query = (f"{query}  WHERE informe{informe}")
    logging.info('despues informe')
    logging.info(query)
    if lavadora:
        if 'WHERE' in query:
            query = (f"{query}  AND lavadora='{lavadora}'")
        else:
            query = (f"{query}  WHERE lavadora='{lavadora}'")
    logging.info('despues lavadora')
    logging.info(query)
    if set_manchas:
        if 'WHERE' in query:
            query = (f"{query}  AND set_manchas='{set_manchas}'")
        else:
            query = (f"{query}  WHERE set_manchas='{set_manchas}'")
    logging.info('despues manchas')
    logging.info(query)
    if instrumento:
        if 'WHERE' in query:
            query = (f"{query}  AND instrumento_lectura='{instrumento}'")
        else:
            query = (f"{query}  WHERE instrumento_lectura='{instrumento}'")
    logging.info('despues insturmento')
    logging.info(query)
    if nombre_ensayo:
        if 'WHERE' in query:
            query = (f"{query}  AND nombre_ensayo{nombre_ensayo}")
        else:
            query = (f"{query}  WHERE nombre_ensayo{nombre_ensayo}")
    logging.info('despues nombre ensayo')
    logging.info(query)
    if temperatura:
        if 'WHERE' in query:
            query = (f"{query}  AND temperatura{temperatura}")
        else:
            query = (f"{query}  WHERE temperatura{temperatura}")
    logging.info('despues temperatura')
    logging.info(query)

    # peticion = 'EWE'
    # sql = f"SELECT * FROM {Tabla} WHERE peticionario='{peticion}'"
    # logging.info(sql)
    # logging.info(engine)

    # df = pd.read_sql(query, engine, parse_dates = {"fecha": {"format": '%d-%m-%Y'}})
    # logging.info('query fecha')
    # logging.info(df['fecha'])
    # js = df.to_json(orient = 'records')
    # logging.info('json query')
    # logging.info(js)

    df = pd.read_sql(query, engine)
    if df.shape[0] > 0:
        df.loc[:, 'lineas'] = 0
        logging.info('Antes for')
        for i in range(df['id_ensayo'].size):
            id_lineas = df['id_ensayo'][i]
            query_count = (f"SELECT COUNT(*) FROM l_antes WHERE id_ensayo = '{id_lineas}'")
            lineas = pd.read_sql(query_count, engine)
            logging.info(lineas)
            df.loc[df.id_ensayo == id_lineas, 'lineas'] = lineas[''][0]
        logging.info('Despues df')
        sql_select_terminados = (f"SELECT * FROM {Tabla_formulas_terminadas}")
        sql_select_no_terminados = (f"SELECT * FROM {Tabla_formulas_sin_terminadas}")
        if(df['id_ensayo'].size > 0):
            logging.info('Entra if')
            sql_select_terminados = (f"{sql_select_terminados} WHERE")
            sql_select_no_terminados = (f"{sql_select_no_terminados} WHERE")
            if(df['id_ensayo'].size == 1):
                logging.info('Entra if=1')
                id_ensayos = df['id_ensayo'][0]
                sql_select_no_terminados = (f"{sql_select_no_terminados} id_ensayo = '{id_ensayos}'")
                sql_select_terminados = (f"{sql_select_terminados} id_ensayo = '{id_ensayos}'")
                logging.info(sql_select_no_terminados)
                logging.info(sql_select_terminados)
            else:
                for i in range(df['id_ensayo'].size):
                    id_ensayos = df['id_ensayo'][i]
                    sql_select_for = (f"id_ensayo = '{id_ensayos}'")
                    logging.info('Vuelta')
                    logging.info(i)
                    if(i < df['id_ensayo'].size - 1):
                        sql_select_for= (f"{sql_select_for} OR")
                    logging.info('sql_select_for')
                    logging.info(sql_select_for)
                    sql_select_terminados = (f"{sql_select_terminados} {sql_select_for}")
                    sql_select_no_terminados = (f"{sql_select_no_terminados} {sql_select_for}")
                    logging.info(sql_select_no_terminados)
                    logging.info(sql_select_terminados)
        if categoria:
            if 'WHERE' in sql_select_terminados or 'WHERE' in sql_select_no_terminados:
                sql_select_terminados = (f"{sql_select_terminados}  AND categoria='{categoria}'")
                sql_select_no_terminados = (f"{sql_select_no_terminados}  AND categoria='{categoria}'")
            else:
                sql_select_terminados = (f"{sql_select_terminados}  WHERE categoria='{categoria}'")
                sql_select_no_terminados = (f"{sql_select_no_terminados}  WHERE categoria='{categoria}'")
        if nombre_formula:
            if 'WHERE' in sql_select_terminados or 'WHERE' in sql_select_no_terminados:
                sql_select_terminados = (f"{sql_select_terminados}  AND nombre_formula'{nombre_formula}'")
                sql_select_no_terminados = (f"{sql_select_no_terminados}  AND nombre_formula'{nombre_formula}'")
            else:
                sql_select_terminados = (f"{sql_select_terminados}  WHERE nombre_formula'{nombre_formula}'")
                sql_select_no_terminados = (f"{sql_select_no_terminados}  WHERE nombre_formula'{nombre_formula}'")

        df_ensayos_terminados = pd.read_sql(sql_select_terminados, engine)
        df_ensayos_no_terminados = pd.read_sql(sql_select_no_terminados, engine)
        logging.info('dfs leidos')

        df_ensayos_total = pd.concat([df_ensayos_terminados, df_ensayos_no_terminados])

        lista_ids = df_ensayos_total['id_ensayo'].unique() #lista ids unicos
        if (len(lista_ids)>0):
            new_sql_select_terminados = (f"SELECT * FROM {Tabla_formulas_terminadas} WHERE id_ensayo='{lista_ids[0]}'")
            print(new_sql_select_terminados)
            new_sql_select_no_terminados = (f"SELECT * FROM {Tabla_formulas_sin_terminadas} WHERE id_ensayo='{lista_ids[0]}'")
            print(new_sql_select_no_terminados)
            for index_id in lista_ids:
                new_sql_select_terminados = (f"{new_sql_select_terminados}  OR id_ensayo='{index_id}'")
                new_sql_select_no_terminados = (f"{new_sql_select_no_terminados}  OR id_ensayo='{index_id}'")


        df_ensayos_no_terminados = pd.read_sql(new_sql_select_no_terminados, engine)
        df_ensayos_terminados = pd.read_sql(new_sql_select_terminados, engine)
        
                
        logging.info(df_ensayos_terminados)
        logging.info(df_ensayos_no_terminados)
        logging.info('Antes casteos')
        df_completo_ensayos_formulas= pd.concat([df_ensayos_terminados, df_ensayos_no_terminados])

        df = df.merge(df_completo_ensayos_formulas, on=['id_ensayo'],how='left')
        for i in range (1 ,51):
            cadena = 'materia_prima_' + str(i) + '_contiene'
            df[cadena] = df[cadena].replace([0, 1], ['False', 'True'])
        logging.info('Despues casteos for')
        df['patron'] = df['patron'].replace([0, 1], ['False', 'True'])
        df['ensayo_terminado'] = df['ensayo_terminado'].replace([0, 1], ['False', 'True'])
    js = df.to_json(orient = 'records', date_format='iso')
    logging.info('json query')
    logging.info(js)
    

    
    # js = dic_json.to_json(orient = 'records')
    # logging.info('json query')
    # logging.info(js)

    # js = pd.read_sql("SELECT * FROM ensayos_detergencia WHERE informe = '3333'", engine)
    # js = js.to_dict(orient = 'dict')
    # dic_json['data'].append({'1':js})
    # df = pd.read_sql("SELECT tipo_mancha, blancos, Soporte FROM manchas", engine)
    # df = df.to_dict(orient = 'dict')
    # dic_json['blancos'].append({'datos':df})

    return js
