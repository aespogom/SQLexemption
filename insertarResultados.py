import logging as lg
import pyodbc
import sqlalchemy
import azure.functions as func
import pandas as pd
from io import StringIO
import json
import math
import numpy as np
import pathlib as pl

import os

Driver = os.environ["DRIVER"]
Server = os.environ["SERVER"]
Port = os.environ["PORT"]
Database = os.environ["DATABASE"]
Uid = os.environ["UID"]
Pwd = os.environ["PWD"]
Tabla_ensayos2 = os.environ["TABLA_ENSAYOS_2"]
Tabla_manchas = os.environ["TABLA_MANCHAS"]
Tabla_lavadora = os.environ["TABLA_LAVADORAS"]
Tabla_instrumentos = os.environ["TABLA_INSTRUMENTOS"]  
Tabla_l_antes = os.environ["TABLA_L_ANTES"]
Tabla_formulas_terminadas = os.environ["TABLA_FORMULAS"]
Tabla_formulas_sin_terminadas = os.environ["TABLA_FORMULAS_INACABADAS"]
Tabla_formulas_cribadas = os.environ["TABLA_CRIBA"]
  

columnas_tabla = {
    'nombre_ensayo': 'nombre_ensayo',
    'Formula': 'n_formula',
    'nombre_formula': 'nombre_formula',
    'dosificaciones(g)': 'dosificacion_g',
    'dosificaciones(ml)': 'dosificacion_ml',
    'densidad': 'densidad',
    'fecha': 'fecha',
    'categoria': 'categoria',
    'Dosis (g)': 'dosis',
    'ph': 'ph',
    'dureza_agua': 'dureza_agua',
    'peticionario': 'peticionario',
    'analista': 'analista',
    'idp': 'idp',
    'informe': 'informe',
    'instrumento_lectura': 'instrumento_lectura',
    'L_antes': 'l_antes',
    'replicado': 'replicado',
    'replicados': 'replicados',
    'set_manchas': 'set_manchas',
    'Mancha': 'mancha',
    'Nombre Mancha': 'nombre_mancha',
    'Naturaleza': 'naturaleza',
    'Soporte': 'soporte',
    'Resultado': 'detergencia',
    'Detergencia': 'detergencia',
    'patron': 'patron',
    'tipo_mancha': 'nombre_mancha',
    'Suciedad': 'mancha',
    'lavadora:': 'lavadora',
    'temperatura:': 'temperatura',
    'Ciclos:': 'ciclos',
    'Ciclos de lavado': 'ciclos',
    'antecedentes': 'antecedentes',
    'conclusiones': 'conclusiones',
    'ensayo_terminado': 'ensayo_terminado',
    'Materia Prima 1': 'materia_prima_1_cantidad',
    'Materia Prima 2': 'materia_prima_2_cantidad',
    'Materia Prima 3': 'materia_prima_3_cantidad',
    'Materia Prima 4': 'materia_prima_4_cantidad',
    'Materia Prima 5': 'materia_prima_5_cantidad',
    'Materia Prima 6': 'materia_prima_6_cantidad',
    'Materia Prima 7': 'materia_prima_7_cantidad',
    'Materia Prima 8': 'materia_prima_8_cantidad',
    'Materia Prima 9': 'materia_prima_9_cantidad',
    'Materia Prima 10': 'materia_prima_10_cantidad',
    'Materia Prima 11': 'materia_prima_11_cantidad',
    'Materia Prima 12': 'materia_prima_12_cantidad',
    'Materia Prima 13': 'materia_prima_13_cantidad',
    'Materia Prima 14': 'materia_prima_14_cantidad',
    'Materia Prima 15': 'materia_prima_15_cantidad',
    'Materia Prima 16': 'materia_prima_16_cantidad',
    'Materia Prima 17': 'materia_prima_17_cantidad',
    'Materia Prima 18': 'materia_prima_18_cantidad',
    'Materia Prima 19': 'materia_prima_19_cantidad',
    'Materia Prima 20': 'materia_prima_20_cantidad',
    'Materia Prima 21': 'materia_prima_21_cantidad',
    'Materia Prima 22': 'materia_prima_22_cantidad',
    'Materia Prima 23': 'materia_prima_23_cantidad',
    'Materia Prima 24': 'materia_prima_24_cantidad',
    'Materia Prima 25': 'materia_prima_25_cantidad',
    'Materia Prima 26': 'materia_prima_26_cantidad',
    'Materia Prima 27': 'materia_prima_27_cantidad',
    'Materia Prima 28': 'materia_prima_28_cantidad',
    'Materia Prima 29': 'materia_prima_29_cantidad',
    'Materia Prima 30': 'materia_prima_30_cantidad',
    'Materia Prima 31': 'materia_prima_31_cantidad',
    'Materia Prima 32': 'materia_prima_32_cantidad',
    'Materia Prima 33': 'materia_prima_33_cantidad',
    'Materia Prima 34': 'materia_prima_34_cantidad',
    'Materia Prima 35': 'materia_prima_35_cantidad',
    'Materia Prima 36': 'materia_prima_36_cantidad',
    'Materia Prima 37': 'materia_prima_37_cantidad',
    'Materia Prima 38': 'materia_prima_38_cantidad',
    'Materia Prima 39': 'materia_prima_39_cantidad',
    'Materia Prima 40': 'materia_prima_40_cantidad',
    'Materia Prima 41': 'materia_prima_41_cantidad',
    'Materia Prima 42': 'materia_prima_42_cantidad',
    'Materia Prima 43': 'materia_prima_43_cantidad',
    'Materia Prima 44': 'materia_prima_44_cantidad',
    'Materia Prima 45': 'materia_prima_45_cantidad',
    'Materia Prima 46': 'materia_prima_46_cantidad',
    'Materia Prima 47': 'materia_prima_47_cantidad',
    'Materia Prima 48': 'materia_prima_48_cantidad',
    'Materia Prima 49': 'materia_prima_49_cantidad',
    'Materia Prima 50': 'materia_prima_50_cantidad',
    'Materia Prima Contiene 1': 'materia_prima_1_contiene',
    'Materia Prima Contiene 2': 'materia_prima_2_contiene',
    'Materia Prima Contiene 3': 'materia_prima_3_contiene',
    'Materia Prima Contiene 4': 'materia_prima_4_contiene',
    'Materia Prima Contiene 5': 'materia_prima_5_contiene',
    'Materia Prima Contiene 6': 'materia_prima_6_contiene',
    'Materia Prima Contiene 7': 'materia_prima_7_contiene',
    'Materia Prima Contiene 8': 'materia_prima_8_contiene',
    'Materia Prima Contiene 9': 'materia_prima_9_contiene',
    'Materia Prima Contiene 10': 'materia_prima_10_contiene',
    'Materia Prima Contiene 11': 'materia_prima_11_contiene',
    'Materia Prima Contiene 12': 'materia_prima_12_contiene',
    'Materia Prima Contiene 13': 'materia_prima_13_contiene',
    'Materia Prima Contiene 14': 'materia_prima_14_contiene',
    'Materia Prima Contiene 15': 'materia_prima_15_contiene',
    'Materia Prima Contiene 16': 'materia_prima_16_contiene',
    'Materia Prima Contiene 17': 'materia_prima_17_contiene',
    'Materia Prima Contiene 18': 'materia_prima_18_contiene',
    'Materia Prima Contiene 19': 'materia_prima_19_contiene',
    'Materia Prima Contiene 20': 'materia_prima_20_contiene',
    'Materia Prima Contiene 21': 'materia_prima_21_contiene',
    'Materia Prima Contiene 22': 'materia_prima_22_contiene',
    'Materia Prima Contiene 23': 'materia_prima_23_contiene',
    'Materia Prima Contiene 24': 'materia_prima_24_contiene',
    'Materia Prima Contiene 25': 'materia_prima_25_contiene',
    'Materia Prima Contiene 26': 'materia_prima_26_contiene',
    'Materia Prima Contiene 27': 'materia_prima_27_contiene',
    'Materia Prima Contiene 28': 'materia_prima_28_contiene',
    'Materia Prima Contiene 29': 'materia_prima_29_contiene',
    'Materia Prima Contiene 30': 'materia_prima_30_contiene',
    'Materia Prima Contiene 31': 'materia_prima_31_contiene',
    'Materia Prima Contiene 32': 'materia_prima_32_contiene',
    'Materia Prima Contiene 33': 'materia_prima_33_contiene',
    'Materia Prima Contiene 34': 'materia_prima_34_contiene',
    'Materia Prima Contiene 35': 'materia_prima_35_contiene',
    'Materia Prima Contiene 36': 'materia_prima_36_contiene',
    'Materia Prima Contiene 37': 'materia_prima_37_contiene',
    'Materia Prima Contiene 38': 'materia_prima_38_contiene',
    'Materia Prima Contiene 39': 'materia_prima_39_contiene',
    'Materia Prima Contiene 40': 'materia_prima_40_contiene',
    'Materia Prima Contiene 41': 'materia_prima_41_contiene',
    'Materia Prima Contiene 42': 'materia_prima_42_contiene',
    'Materia Prima Contiene 43': 'materia_prima_43_contiene',
    'Materia Prima Contiene 44': 'materia_prima_44_contiene',
    'Materia Prima Contiene 45': 'materia_prima_45_contiene',
    'Materia Prima Contiene 46': 'materia_prima_46_contiene',
    'Materia Prima Contiene 47': 'materia_prima_47_contiene',
    'Materia Prima Contiene 48': 'materia_prima_48_contiene',
    'Materia Prima Contiene 49': 'materia_prima_49_contiene',
    'Materia Prima Contiene 50': 'materia_prima_50_contiene'
}

engine = sqlalchemy.create_engine(f'mssql+pyodbc://{Uid}:{Pwd}@{Server}:{str(Port)}/{Database}?driver={Driver}', echo = True)

def large(arr, media):

    #root element varible 
    max_ = arr[0]
    
    for ele in arr:
        if(np.absolute(ele-media) > np.absolute(max_-media)):
           max_ = ele

    # print('detergencia a eliminar: ', max_)
    return max_


def insertar_resultados(req_body):
    csv_antes = req_body.get('csv_antes')
    csv_despues = req_body.get('csv_despues')
    csv_correccion_despues = req_body.get('csv_correccion_despues')
    csv_correccion_antes = req_body.get('csv_correccion_antes')

    replicados = req_body.get('replicados')
    numero_formulas = req_body.get('numero_formula')

    nombre_ensayo = req_body.get('nombre_ensayo')
    idp = req_body.get('idp')
    fecha = req_body.get('fecha')
    temperatura = req_body.get('temperatura')
    dureza_agua = req_body.get('dureza_agua')

    lavadora= req_body.get('lavadora')
    instrumento_lectura = req_body.get('instrumento_lectura')
    analista = req_body.get('analista')
    
    peticionario = req_body.get('peticionario')
    informe = req_body.get('informe')
    set_manchas = req_body.get('set_manchas')
    set_manchas = set_manchas['name']

    ciclos = req_body.get('ciclo')
    ciclos = ciclos['name']

    antecedentes = req_body.get('antecedentes')
    conclusiones = req_body.get('conclusiones')

    estado_ensayo = req_body.get('estado')


    dict_maestros = pd.read_sql(f"SELECT Suciedad, tipo_mancha, Naturaleza, Soporte, Posicion, Blancos FROM {Tabla_manchas} WHERE set_manchas = '{set_manchas}'", engine)

    if csv_antes and not csv_despues:
        lg.info('Entra por si y not')
        csv_antes = StringIO(csv_antes)
        df_antes = pd.read_csv(csv_antes, sep=',', names= ['No','Name','L_antes','a','b','Nada'],header=0)
        df_antes.loc[:,'Monitor'] = df_antes['Name'].str.split('-').str[0]
        df_antes.loc[:,'Monitor'] = df_antes['Monitor'].str.replace('.', '')
        #df_antes.loc[:,'id'] = df_antes['Name'].str.split('-').str[1]
        df_antes['id'] = df_antes.groupby(['Monitor']).cumcount()+1
        df_antes_final = df_antes[['Monitor','id','L_antes']].copy()

        df_completo_sin_correccion = df_antes_final

        lg.info("Lectura bien")


        if csv_correccion_antes:
            csv_correccion = StringIO(csv_correccion_antes)
            df_antes_cor = pd.read_csv(csv_correccion, sep=',', names= ['No','Name','L_antes_cor','a','b','Nada'],header=0)
            df_antes_cor.loc[:,'Monitor'] = df_antes_cor['Name'].str.split('-').str[0]
            df_antes_cor.loc[:,'Monitor'] = df_antes_cor['Monitor'].str.replace('.', '')
            df_antes_cor['id'] = df_antes_cor.groupby(['Monitor']).cumcount()+1
            df_antes_cor_final = df_antes_cor[['Monitor','id','L_antes_cor']].copy()

            # Mergeo el completo sin correccion con la correccion
            df_completo = df_antes_final.merge(df_antes_cor_final, on=['Monitor','id'],how='left')

            df_completo.loc[~df_completo['L_antes_cor'].isna(), 'L_antes'] = df_completo['L_antes_cor']
        else:
            df_completo = df_completo_sin_correccion.copy()
        # Insertamos el csv antes en bd a la espera de terminar el ensayo
        lg.info('antes completo')
        df_completo.loc[:,'Posicion'] = df_completo['id']
        lg.info('despues completo')
        df_completo.loc[(df_completo['Monitor'].astype('int64')%2)==0, 'Posicion'] = df_completo['id']+(int(dict_maestros.shape[0]/2))
        lg.info('antes completo maestros')
        df_completo_maestros = df_completo.merge(dict_maestros, on='Posicion', how='left')
        lg.info('despues completo maestros')
        # df_completo_maestros.loc[:, 'Detergencia'].fillna(0)

        

        lg.info("csv antes incompleto leido")

    if csv_antes and csv_despues:
        lg.info('Entra por si y si')

        csv_antes = StringIO(csv_antes)
        df_antes = pd.read_csv(csv_antes, sep=',', names= ['No','Name','L_antes','a','b','Nada'],header=0)
        df_antes.loc[:,'Monitor'] = df_antes['Name'].str.split('-').str[0]
        df_antes.loc[:,'Monitor'] = df_antes['Monitor'].str.replace('.', '')
        #df_antes.loc[:,'id'] = df_antes['Name'].str.split('-').str[1]
        df_antes['id'] = df_antes.groupby(['Monitor']).cumcount()+1
        df_antes_final = df_antes[['Monitor','id','L_antes']].copy()
        lg.info('Lectura antes y despues')

        csv_despues = StringIO(csv_despues)
        df_despues = pd.read_csv(csv_despues, sep=',', names= ['No','Name','L_despues','a','b','Nada'],header=0)
        df_despues.loc[:,'Monitor'] = df_despues['Name'].str.split('-').str[0]
        df_despues.loc[:,'Monitor'] = df_despues['Monitor'].str.replace('.', '')
        #df_despues.loc[:,'id'] = df_despues['Name'].str.split('-').str[1]
        df_despues['id'] = df_despues.groupby(['Monitor']).cumcount()+1
        df_despues_final = df_despues[['Monitor','id','L_despues']].copy()

        # Mergeo de antes con despues sin correccion
        df_completo_sin_correccion = df_antes_final.merge(df_despues_final, on=['Monitor','id'],how='left')
        df_completo = None

        if csv_correccion_despues:
            csv_correccion = StringIO(csv_correccion_despues)
            df_despues_cor = pd.read_csv(csv_correccion, sep=',', names= ['No','Name','L_despues_cor','a','b','Nada'],header=0)
            df_despues_cor.loc[:,'Monitor'] = df_despues_cor['Name'].str.split('-').str[0]
            df_despues_cor.loc[:,'Monitor'] = df_despues_cor['Monitor'].str.replace('.', '')
            df_despues_cor['id'] = df_despues_cor.groupby(['Monitor']).cumcount()+1
            df_despues_cor_final = df_despues_cor[['Monitor','id','L_despues_cor']].copy()

            #Mergeo el completo sin correccion con la correccion
            df_completo = df_completo_sin_correccion.merge(df_despues_cor_final, on=['Monitor','id'],how='left')

            df_completo.loc[~df_completo['L_despues_cor'].isna(), 'L_despues'] = df_completo['L_despues_cor']

        if csv_correccion_antes:
            csv_correccion = StringIO(csv_correccion_antes)
            df_antes_cor = pd.read_csv(csv_correccion, sep=',', names= ['No','Name','L_antes_cor','a','b','Nada'],header=0)
            df_antes_cor.loc[:,'Monitor'] = df_antes_cor['Name'].str.split('-').str[0]
            df_antes_cor.loc[:,'Monitor'] = df_antes_cor['Monitor'].str.replace('.', '')
            df_antes_cor['id'] = df_antes_cor.groupby(['Monitor']).cumcount()+1
            df_antes_cor_final = df_antes_cor[['Monitor','id','L_antes_cor']].copy()

            #Mergeo el completo sin correccion con la correccion
            if df_completo:
                df_completo = df_completo.merge(df_antes_cor_final, on=['Monitor', 'id'], how='left')
            else:
                df_completo = df_completo_sin_correccion.merge(df_antes_cor_final, on=['Monitor','id'],how='left')

            df_completo.loc[~df_completo['L_antes_cor'].isna(), 'L_antes'] = df_completo['L_antes_cor']
        
        if not df_completo:
            df_completo = df_completo_sin_correccion.copy()

        df_completo.loc[:,'Posicion'] = df_completo['id']

        df_completo.loc[(df_completo['Monitor'].astype('int64')%2)==0, 'Posicion'] = df_completo['id']+(int(dict_maestros.shape[0]/2))

        df_completo_maestros = df_completo.merge(dict_maestros, on='Posicion', how='left')

        df_completo_maestros.loc[:, 'Detergencia'] = ((df_completo_maestros['L_despues']-df_completo_maestros['L_antes'])/(df_completo_maestros['Blancos']-df_completo_maestros['L_antes']))*100

    n_replicados = replicados['name']

    lg.info("Antes formulas")

    try:
        n_replicados = int(n_replicados)
    except:
        return func.HttpResponse(f"error en el parseado.{n_replicados}",status_code=500)

    df_completo_maestros.loc[:,'Formula'] = df_completo_maestros['Monitor'].astype('float64')/(n_replicados*2)

    df_completo_maestros.loc[:,'Formula'] = np.ceil(df_completo_maestros['Formula'])

    factor_replicados = len(df_completo_maestros)/int(numero_formulas)/int(n_replicados)

    lista_replicas = list()
    for formula in range(1,numero_formulas+1):
        for replicado in range(1,int(n_replicados)+1):
            for i in range(int(factor_replicados)):
                lista_replicas.append(replicado)


    df_completo_maestros.loc[:, 'replicado'] = lista_replicas
    df_completo_maestros.loc[:,'nombre_ensayo'] = nombre_ensayo
    df_completo_maestros.loc[:,'idp'] = idp
    df_completo_maestros.loc[:,'fecha'] = fecha
    df_completo_maestros.loc[:,'temperatura'] = temperatura
    df_completo_maestros.loc[:,'dureza_agua'] = dureza_agua
    df_completo_maestros.loc[:,'lavadora'] = lavadora
    df_completo_maestros.loc[:,'analista'] = analista
    df_completo_maestros.loc[:,'instrumento_lectura'] = instrumento_lectura
    df_completo_maestros.loc[:,'replicados'] = n_replicados
    df_completo_maestros.loc[:,'peticionario'] = peticionario
    df_completo_maestros.loc[:,'informe'] = informe
    df_completo_maestros.loc[:,'set_manchas'] = set_manchas
    df_completo_maestros.loc[:,'ciclos'] = ciclos
    df_completo_maestros.loc[:,'antecedentes'] = antecedentes
    df_completo_maestros.loc[:,'conclusiones'] = conclusiones
    df_completo_maestros.loc[:,'ensayo_terminado'] = estado_ensayo

    for i in range(1,int(numero_formulas)+1):

        detergente = req_body.get('detergente'+str(i))
        nombre_formula = detergente['nombre_formula']
        categoria = detergente['categoria']
        dosificaciones_g = detergente['dosificaciones(g)']
        dosificaciones_ml = detergente['dosificaciones(ml)']
        densidad = detergente['densidad']
        ph = detergente['ph']
        patron = detergente['patron']
        materia_prima_1_cantidad = detergente['materia_prima_1_cantidad']
        materia_prima_1_contiene = detergente['materia_prima_1_contiene']
        materia_prima_2_cantidad = detergente['materia_prima_2_cantidad']
        materia_prima_2_contiene = detergente['materia_prima_2_contiene']
        materia_prima_3_cantidad = detergente['materia_prima_3_cantidad']
        materia_prima_3_contiene = detergente['materia_prima_3_contiene']
        materia_prima_4_cantidad = detergente['materia_prima_4_cantidad']
        materia_prima_4_contiene = detergente['materia_prima_4_contiene']
        materia_prima_5_cantidad = detergente['materia_prima_5_cantidad']
        materia_prima_5_contiene = detergente['materia_prima_5_contiene']
        materia_prima_6_cantidad = detergente['materia_prima_6_cantidad']
        materia_prima_6_contiene = detergente['materia_prima_6_contiene']
        materia_prima_7_cantidad = detergente['materia_prima_7_cantidad']
        materia_prima_7_contiene = detergente['materia_prima_7_contiene']
        materia_prima_8_cantidad = detergente['materia_prima_8_cantidad']
        materia_prima_8_contiene = detergente['materia_prima_8_contiene']
        materia_prima_9_cantidad = detergente['materia_prima_9_cantidad']
        materia_prima_9_contiene = detergente['materia_prima_9_contiene']
        materia_prima_10_cantidad = detergente['materia_prima_10_cantidad']
        materia_prima_10_contiene = detergente['materia_prima_10_contiene']
        materia_prima_11_cantidad = detergente['materia_prima_11_cantidad']
        materia_prima_11_contiene = detergente['materia_prima_11_contiene']
        materia_prima_12_cantidad = detergente['materia_prima_12_cantidad']
        materia_prima_12_contiene = detergente['materia_prima_12_contiene']
        materia_prima_13_cantidad = detergente['materia_prima_13_cantidad']
        materia_prima_13_contiene = detergente['materia_prima_13_contiene']
        materia_prima_14_cantidad = detergente['materia_prima_14_cantidad']
        materia_prima_14_contiene = detergente['materia_prima_14_contiene']
        materia_prima_15_cantidad = detergente['materia_prima_15_cantidad']
        materia_prima_15_contiene = detergente['materia_prima_15_contiene']
        materia_prima_16_cantidad = detergente['materia_prima_16_cantidad']
        materia_prima_16_contiene = detergente['materia_prima_16_contiene']
        materia_prima_17_cantidad = detergente['materia_prima_17_cantidad']
        materia_prima_17_contiene = detergente['materia_prima_17_contiene']
        materia_prima_18_cantidad = detergente['materia_prima_18_cantidad']
        materia_prima_18_contiene = detergente['materia_prima_18_contiene']
        materia_prima_19_cantidad = detergente['materia_prima_19_cantidad']
        materia_prima_19_contiene = detergente['materia_prima_19_contiene']
        materia_prima_20_cantidad = detergente['materia_prima_20_cantidad']
        materia_prima_20_contiene = detergente['materia_prima_20_contiene']
        materia_prima_21_cantidad = detergente['materia_prima_21_cantidad']
        materia_prima_21_contiene = detergente['materia_prima_21_contiene']
        materia_prima_22_cantidad = detergente['materia_prima_22_cantidad']
        materia_prima_22_contiene = detergente['materia_prima_22_contiene']
        materia_prima_23_cantidad = detergente['materia_prima_23_cantidad']
        materia_prima_23_contiene = detergente['materia_prima_23_contiene']
        materia_prima_24_cantidad = detergente['materia_prima_24_cantidad']
        materia_prima_24_contiene = detergente['materia_prima_24_contiene']
        materia_prima_25_cantidad = detergente['materia_prima_25_cantidad']
        materia_prima_25_contiene = detergente['materia_prima_25_contiene']
        materia_prima_26_cantidad = detergente['materia_prima_26_cantidad']
        materia_prima_26_contiene = detergente['materia_prima_26_contiene']
        materia_prima_27_cantidad = detergente['materia_prima_27_cantidad']
        materia_prima_27_contiene = detergente['materia_prima_27_contiene']
        materia_prima_28_cantidad = detergente['materia_prima_28_cantidad']
        materia_prima_28_contiene = detergente['materia_prima_28_contiene']
        materia_prima_29_cantidad = detergente['materia_prima_29_cantidad']
        materia_prima_29_contiene = detergente['materia_prima_29_contiene']
        materia_prima_30_cantidad = detergente['materia_prima_30_cantidad']
        materia_prima_30_contiene = detergente['materia_prima_30_contiene']
        materia_prima_31_cantidad = detergente['materia_prima_31_cantidad']
        materia_prima_31_contiene = detergente['materia_prima_31_contiene']
        materia_prima_32_cantidad = detergente['materia_prima_32_cantidad']
        materia_prima_32_contiene = detergente['materia_prima_32_contiene']
        materia_prima_33_cantidad = detergente['materia_prima_33_cantidad']
        materia_prima_33_contiene = detergente['materia_prima_33_contiene']
        materia_prima_34_cantidad = detergente['materia_prima_34_cantidad']
        materia_prima_34_contiene = detergente['materia_prima_34_contiene']
        materia_prima_35_cantidad = detergente['materia_prima_35_cantidad']
        materia_prima_35_contiene = detergente['materia_prima_35_contiene']
        materia_prima_36_cantidad = detergente['materia_prima_36_cantidad']
        materia_prima_36_contiene = detergente['materia_prima_36_contiene']
        materia_prima_37_cantidad = detergente['materia_prima_37_cantidad']
        materia_prima_37_contiene = detergente['materia_prima_37_contiene']
        materia_prima_38_cantidad = detergente['materia_prima_38_cantidad']
        materia_prima_38_contiene = detergente['materia_prima_38_contiene']
        materia_prima_39_cantidad = detergente['materia_prima_39_cantidad']
        materia_prima_39_contiene = detergente['materia_prima_39_contiene']
        materia_prima_40_cantidad = detergente['materia_prima_40_cantidad']
        materia_prima_40_contiene = detergente['materia_prima_40_contiene']
        materia_prima_41_cantidad = detergente['materia_prima_41_cantidad']
        materia_prima_41_contiene = detergente['materia_prima_41_contiene']
        materia_prima_42_cantidad = detergente['materia_prima_42_cantidad']
        materia_prima_42_contiene = detergente['materia_prima_42_contiene']
        materia_prima_43_cantidad = detergente['materia_prima_43_cantidad']
        materia_prima_43_contiene = detergente['materia_prima_43_contiene']
        materia_prima_44_cantidad = detergente['materia_prima_44_cantidad']
        materia_prima_44_contiene = detergente['materia_prima_44_contiene']
        materia_prima_45_cantidad = detergente['materia_prima_45_cantidad']
        materia_prima_45_contiene = detergente['materia_prima_45_contiene']
        materia_prima_46_cantidad = detergente['materia_prima_46_cantidad']
        materia_prima_46_contiene = detergente['materia_prima_46_contiene']
        materia_prima_47_cantidad = detergente['materia_prima_47_cantidad']
        materia_prima_47_contiene = detergente['materia_prima_47_contiene']
        materia_prima_48_cantidad = detergente['materia_prima_48_cantidad']
        materia_prima_48_contiene = detergente['materia_prima_48_contiene']
        materia_prima_49_cantidad = detergente['materia_prima_49_cantidad']
        materia_prima_49_contiene = detergente['materia_prima_49_contiene']
        materia_prima_50_cantidad = detergente['materia_prima_50_cantidad']
        materia_prima_50_contiene = detergente['materia_prima_50_contiene']

        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'nombre_formula'] = nombre_formula
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'categoria'] = categoria
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'dosificaciones(g)'] = dosificaciones_g
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'dosificaciones(ml)'] = dosificaciones_ml
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'densidad'] = densidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'patron'] = patron
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'ph'] = ph
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'Dosis (g)'] = dosificaciones_g

        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_1_cantidad'] = materia_prima_1_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_1_contiene'] = materia_prima_1_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_2_cantidad'] = materia_prima_2_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_2_contiene'] = materia_prima_2_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_3_cantidad'] = materia_prima_3_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_3_contiene'] = materia_prima_3_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_4_cantidad'] = materia_prima_4_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_4_contiene'] = materia_prima_4_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_5_cantidad'] = materia_prima_5_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_5_contiene'] = materia_prima_5_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_6_cantidad'] = materia_prima_6_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_6_contiene'] = materia_prima_6_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_7_cantidad'] = materia_prima_7_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_7_contiene'] = materia_prima_7_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_8_cantidad'] = materia_prima_8_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_8_contiene'] = materia_prima_8_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_9_cantidad'] = materia_prima_9_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_9_contiene'] = materia_prima_9_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_10_cantidad'] = materia_prima_10_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_10_contiene'] = materia_prima_10_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_11_cantidad'] = materia_prima_11_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_11_contiene'] = materia_prima_11_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_12_cantidad'] = materia_prima_12_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_12_contiene'] = materia_prima_12_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_13_cantidad'] = materia_prima_13_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_13_contiene'] = materia_prima_13_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_14_cantidad'] = materia_prima_14_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_14_contiene'] = materia_prima_14_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_15_cantidad'] = materia_prima_15_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_15_contiene'] = materia_prima_15_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_16_cantidad'] = materia_prima_16_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_16_contiene'] = materia_prima_16_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_17_cantidad'] = materia_prima_17_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_17_contiene'] = materia_prima_17_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_18_cantidad'] = materia_prima_18_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_18_contiene'] = materia_prima_18_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_19_cantidad'] = materia_prima_19_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_19_contiene'] = materia_prima_19_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_20_cantidad'] = materia_prima_20_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_20_contiene'] = materia_prima_20_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_21_cantidad'] = materia_prima_21_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_21_contiene'] = materia_prima_21_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_22_cantidad'] = materia_prima_22_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_22_contiene'] = materia_prima_22_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_23_cantidad'] = materia_prima_23_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_23_contiene'] = materia_prima_23_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_24_cantidad'] = materia_prima_24_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_24_contiene'] = materia_prima_24_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_25_cantidad'] = materia_prima_25_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_25_contiene'] = materia_prima_25_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_26_cantidad'] = materia_prima_26_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_26_contiene'] = materia_prima_26_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_27_cantidad'] = materia_prima_27_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_27_contiene'] = materia_prima_27_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_28_cantidad'] = materia_prima_28_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_28_contiene'] = materia_prima_28_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_29_cantidad'] = materia_prima_29_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_29_contiene'] = materia_prima_29_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_30_cantidad'] = materia_prima_30_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_30_contiene'] = materia_prima_30_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_31_cantidad'] = materia_prima_31_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_31_contiene'] = materia_prima_31_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_32_cantidad'] = materia_prima_32_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_32_contiene'] = materia_prima_32_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_33_cantidad'] = materia_prima_33_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_33_contiene'] = materia_prima_33_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_34_cantidad'] = materia_prima_34_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_34_contiene'] = materia_prima_34_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_35_cantidad'] = materia_prima_35_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_35_contiene'] = materia_prima_35_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_36_cantidad'] = materia_prima_36_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_36_contiene'] = materia_prima_36_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_37_cantidad'] = materia_prima_37_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_37_contiene'] = materia_prima_37_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_38_cantidad'] = materia_prima_38_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_38_contiene'] = materia_prima_38_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_39_cantidad'] = materia_prima_39_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_39_contiene'] = materia_prima_39_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_40_cantidad'] = materia_prima_40_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_40_contiene'] = materia_prima_40_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_41_cantidad'] = materia_prima_41_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_41_contiene'] = materia_prima_41_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_42_cantidad'] = materia_prima_42_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_42_contiene'] = materia_prima_42_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_43_cantidad'] = materia_prima_43_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_43_contiene'] = materia_prima_43_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_44_cantidad'] = materia_prima_44_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_44_contiene'] = materia_prima_44_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_45_cantidad'] = materia_prima_45_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_45_contiene'] = materia_prima_45_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_46_cantidad'] = materia_prima_46_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_46_contiene'] = materia_prima_46_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_47_cantidad'] = materia_prima_47_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_47_contiene'] = materia_prima_47_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_48_cantidad'] = materia_prima_48_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_48_contiene'] = materia_prima_48_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_49_cantidad'] = materia_prima_49_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_49_contiene'] = materia_prima_49_contiene
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_50_cantidad'] = materia_prima_50_cantidad
        df_completo_maestros.loc[df_completo_maestros['Formula'].astype('int64')==i,'materia_prima_50_contiene'] = materia_prima_50_contiene

        lg.info(df_completo_maestros)

    lg.info('fin df_completo_maestros')

    df_completo_maestros = df_completo_maestros.rename(columns=columnas_tabla)

    lg.info('Rename df_completo_maestros')

    #Seleccionamos los datos a introducir en la tabla maestros

    df_completo_ensayos_maestros = df_completo_maestros[['nombre_ensayo', 'fecha', 'lavadora', 'dureza_agua', 'peticionario', 'temperatura', 'analista', 'idp',
    'ciclos', 'informe', 'instrumento_lectura', 'replicados', 'set_manchas','antecedentes', 'conclusiones', 'ensayo_terminado']]
    lg.info('Columnas')
    df_completo_ensayos_maestros = df_completo_ensayos_maestros.iloc[[0]]
    not_csv_despues = False

    
    if csv_despues:
        data = []
        datacribada = []
        datamanchas = []
        for formula in range(1, numero_formulas + 1):
            detergencias = list()
            for replicado in range(1, int(n_replicados) + 1):
                index_formula = (df_completo_maestros['n_formula'].astype('int64')==formula) & (df_completo_maestros['replicado'].astype('int64')==replicado)
                df_formula = df_completo_maestros[index_formula][['detergencia']].fillna(0)
                manchas = df_formula['detergencia'].to_numpy()
                detergencias.append(manchas.tolist())
                datamanchas.append(df_completo_maestros[index_formula].fillna(0))

            lista_manchas = datamanchas[0]['nombre_mancha'].tolist()
            for row in range(0, len(detergencias[0])):
                mancha = lista_manchas[row] #string nombre mancha
                if mancha != 'VACIO':
                    array_detergencia = []
                    for rep in range(0, int(n_replicados)):
                        # para la desv no contamos con las detergencias == 0, las eliminamos de las estadisticas
                        array_detergencia.append(detergencias[rep][row])
                    desviacion = np.std(array_detergencia, axis=0, ddof=1)
                    media = np.mean(array_detergencia, axis=0)
                    new_desv=0
                    if desviacion>5:
                        for e in [0,1]:
                            # nos cargamos 2 datos como maximo para desv>5
                            if e==0 or (e==1 and new_desv>5):
                                max_item = large(array_detergencia, np.mean(array_detergencia, axis=0))
                                array_detergencia.remove(max_item)
                                for r in range(0, int(n_replicados)):
                                    dataframe =  datamanchas[r]
                                    # buscamos en el dataframe en que de los replicados esta la detergencia que desvia mas
                                    if dataframe.loc[dataframe['nombre_mancha']==mancha, 'detergencia'].shape[0] > 0:
                                        if dataframe.loc[dataframe['nombre_mancha']==mancha, 'detergencia'].values[0] == max_item:
                                            index = dataframe.index[dataframe['nombre_mancha'] == mancha] 
                                            datacribada.append(datamanchas[r].loc[dataframe['nombre_mancha']==mancha])
                                            datamanchas[r].drop(index, inplace=True)
                                            # print('eliminar formulas: ', formula, ' replicado: ', r+1, 'mancha: ', mancha, 'deterg: ', max_item)
                                            new_desv = np.std(array_detergencia, axis=0,ddof=1)
                                    
                    # despues de haber revisado todos los replicados para esa mancha, lo que no hayamos drop, append en la lista final                   
                    for r in range(0, int(n_replicados)):
                        data.append(datamanchas[r].loc[(datamanchas[r].nombre_mancha == mancha) & (datamanchas[r].detergencia != 0)])
                
            # print(len(data))
            datamanchas=[]
            
        df = pd.concat(data)
        df_cribado = pd.concat(datacribada)

        df_completo_ensayos_formulas_criba = df_cribado[['n_formula','replicado','nombre_formula', 'categoria', 'dosificacion_ml', 'dosificacion_g', 'densidad', 'ph', 'mancha', 'nombre_mancha',
        'naturaleza', 'soporte', 'detergencia', 'patron', 'materia_prima_1_cantidad', 'materia_prima_2_cantidad', 'materia_prima_3_cantidad', 'materia_prima_4_cantidad', 'materia_prima_5_cantidad', 'materia_prima_6_cantidad',
        'materia_prima_7_cantidad', 'materia_prima_8_cantidad', 'materia_prima_9_cantidad', 'materia_prima_10_cantidad', 'materia_prima_11_cantidad', 'materia_prima_12_cantidad', 'materia_prima_13_cantidad', 'materia_prima_14_cantidad',
        'materia_prima_15_cantidad', 'materia_prima_16_cantidad', 'materia_prima_17_cantidad', 'materia_prima_18_cantidad', 'materia_prima_19_cantidad', 'materia_prima_20_cantidad', 'materia_prima_21_cantidad', 'materia_prima_22_cantidad',
        'materia_prima_23_cantidad', 'materia_prima_24_cantidad', 'materia_prima_25_cantidad', 'materia_prima_26_cantidad', 'materia_prima_27_cantidad', 'materia_prima_28_cantidad', 'materia_prima_29_cantidad', 'materia_prima_30_cantidad',
        'materia_prima_31_cantidad', 'materia_prima_32_cantidad', 'materia_prima_33_cantidad', 'materia_prima_34_cantidad', 'materia_prima_35_cantidad', 'materia_prima_36_cantidad', 'materia_prima_37_cantidad', 'materia_prima_38_cantidad',
        'materia_prima_39_cantidad', 'materia_prima_40_cantidad', 'materia_prima_41_cantidad', 'materia_prima_42_cantidad', 'materia_prima_43_cantidad', 'materia_prima_44_cantidad', 'materia_prima_45_cantidad', 'materia_prima_46_cantidad',
        'materia_prima_47_cantidad', 'materia_prima_48_cantidad', 'materia_prima_49_cantidad', 'materia_prima_50_cantidad', 'materia_prima_1_contiene', 'materia_prima_2_contiene', 'materia_prima_3_contiene', 'materia_prima_4_contiene',
        'materia_prima_5_contiene', 'materia_prima_6_contiene', 'materia_prima_7_contiene', 'materia_prima_8_contiene', 'materia_prima_9_contiene', 'materia_prima_10_contiene', 'materia_prima_11_contiene', 'materia_prima_12_contiene',
        'materia_prima_13_contiene', 'materia_prima_14_contiene', 'materia_prima_15_contiene', 'materia_prima_16_contiene', 'materia_prima_17_contiene', 'materia_prima_18_contiene', 'materia_prima_19_contiene', 'materia_prima_20_contiene',
        'materia_prima_21_contiene', 'materia_prima_22_contiene', 'materia_prima_23_contiene', 'materia_prima_24_contiene', 'materia_prima_25_contiene', 'materia_prima_26_contiene', 'materia_prima_27_contiene', 'materia_prima_28_contiene',
        'materia_prima_29_contiene', 'materia_prima_30_contiene', 'materia_prima_31_contiene', 'materia_prima_32_contiene', 'materia_prima_33_contiene', 'materia_prima_34_contiene', 'materia_prima_35_contiene',
        'materia_prima_36_contiene', 'materia_prima_37_contiene', 'materia_prima_38_contiene', 'materia_prima_39_contiene', 'materia_prima_40_contiene', 'materia_prima_41_contiene', 'materia_prima_42_contiene', 'materia_prima_43_contiene',
        'materia_prima_44_contiene', 'materia_prima_45_contiene', 'materia_prima_46_contiene', 'materia_prima_47_contiene', 'materia_prima_48_contiene', 'materia_prima_49_contiene', 'materia_prima_50_contiene']]
        
        df_completo_ensayos_formulas_cribado = df[['n_formula','replicado','nombre_formula', 'categoria', 'dosificacion_ml', 'dosificacion_g', 'densidad', 'ph', 'mancha', 'nombre_mancha',
        'naturaleza', 'soporte', 'detergencia', 'patron', 'materia_prima_1_cantidad', 'materia_prima_2_cantidad', 'materia_prima_3_cantidad', 'materia_prima_4_cantidad', 'materia_prima_5_cantidad', 'materia_prima_6_cantidad',
        'materia_prima_7_cantidad', 'materia_prima_8_cantidad', 'materia_prima_9_cantidad', 'materia_prima_10_cantidad', 'materia_prima_11_cantidad', 'materia_prima_12_cantidad', 'materia_prima_13_cantidad', 'materia_prima_14_cantidad',
        'materia_prima_15_cantidad', 'materia_prima_16_cantidad', 'materia_prima_17_cantidad', 'materia_prima_18_cantidad', 'materia_prima_19_cantidad', 'materia_prima_20_cantidad', 'materia_prima_21_cantidad', 'materia_prima_22_cantidad',
        'materia_prima_23_cantidad', 'materia_prima_24_cantidad', 'materia_prima_25_cantidad', 'materia_prima_26_cantidad', 'materia_prima_27_cantidad', 'materia_prima_28_cantidad', 'materia_prima_29_cantidad', 'materia_prima_30_cantidad',
        'materia_prima_31_cantidad', 'materia_prima_32_cantidad', 'materia_prima_33_cantidad', 'materia_prima_34_cantidad', 'materia_prima_35_cantidad', 'materia_prima_36_cantidad', 'materia_prima_37_cantidad', 'materia_prima_38_cantidad',
        'materia_prima_39_cantidad', 'materia_prima_40_cantidad', 'materia_prima_41_cantidad', 'materia_prima_42_cantidad', 'materia_prima_43_cantidad', 'materia_prima_44_cantidad', 'materia_prima_45_cantidad', 'materia_prima_46_cantidad',
        'materia_prima_47_cantidad', 'materia_prima_48_cantidad', 'materia_prima_49_cantidad', 'materia_prima_50_cantidad', 'materia_prima_1_contiene', 'materia_prima_2_contiene', 'materia_prima_3_contiene', 'materia_prima_4_contiene',
        'materia_prima_5_contiene', 'materia_prima_6_contiene', 'materia_prima_7_contiene', 'materia_prima_8_contiene', 'materia_prima_9_contiene', 'materia_prima_10_contiene', 'materia_prima_11_contiene', 'materia_prima_12_contiene',
        'materia_prima_13_contiene', 'materia_prima_14_contiene', 'materia_prima_15_contiene', 'materia_prima_16_contiene', 'materia_prima_17_contiene', 'materia_prima_18_contiene', 'materia_prima_19_contiene', 'materia_prima_20_contiene',
        'materia_prima_21_contiene', 'materia_prima_22_contiene', 'materia_prima_23_contiene', 'materia_prima_24_contiene', 'materia_prima_25_contiene', 'materia_prima_26_contiene', 'materia_prima_27_contiene', 'materia_prima_28_contiene',
        'materia_prima_29_contiene', 'materia_prima_30_contiene', 'materia_prima_31_contiene', 'materia_prima_32_contiene', 'materia_prima_33_contiene', 'materia_prima_34_contiene', 'materia_prima_35_contiene',
        'materia_prima_36_contiene', 'materia_prima_37_contiene', 'materia_prima_38_contiene', 'materia_prima_39_contiene', 'materia_prima_40_contiene', 'materia_prima_41_contiene', 'materia_prima_42_contiene', 'materia_prima_43_contiene',
        'materia_prima_44_contiene', 'materia_prima_45_contiene', 'materia_prima_46_contiene', 'materia_prima_47_contiene', 'materia_prima_48_contiene', 'materia_prima_49_contiene', 'materia_prima_50_contiene']]
    else:
        lg.info('Entra sin csvantes')
        not_csv_despues = True
        df_l_antes = df_completo_maestros[['l_antes', 'Monitor', 'id']]
        
        df_completo_ensayos_formulas_sin_cribar = df_completo_maestros[['n_formula','replicado','nombre_formula', 'categoria', 'dosificacion_ml', 'dosificacion_g', 'densidad', 'ph', 'mancha', 'nombre_mancha',
        'naturaleza', 'soporte', 'patron', 'materia_prima_1_cantidad', 'materia_prima_2_cantidad', 'materia_prima_3_cantidad', 'materia_prima_4_cantidad', 'materia_prima_5_cantidad', 'materia_prima_6_cantidad',
        'materia_prima_7_cantidad', 'materia_prima_8_cantidad', 'materia_prima_9_cantidad', 'materia_prima_10_cantidad', 'materia_prima_11_cantidad', 'materia_prima_12_cantidad', 'materia_prima_13_cantidad', 'materia_prima_14_cantidad',
        'materia_prima_15_cantidad', 'materia_prima_16_cantidad', 'materia_prima_17_cantidad', 'materia_prima_18_cantidad', 'materia_prima_19_cantidad', 'materia_prima_20_cantidad', 'materia_prima_21_cantidad', 'materia_prima_22_cantidad',
        'materia_prima_23_cantidad', 'materia_prima_24_cantidad', 'materia_prima_25_cantidad', 'materia_prima_26_cantidad', 'materia_prima_27_cantidad', 'materia_prima_28_cantidad', 'materia_prima_29_cantidad', 'materia_prima_30_cantidad',
        'materia_prima_31_cantidad', 'materia_prima_32_cantidad', 'materia_prima_33_cantidad', 'materia_prima_34_cantidad', 'materia_prima_35_cantidad', 'materia_prima_36_cantidad', 'materia_prima_37_cantidad', 'materia_prima_38_cantidad',
        'materia_prima_39_cantidad', 'materia_prima_40_cantidad', 'materia_prima_41_cantidad', 'materia_prima_42_cantidad', 'materia_prima_43_cantidad', 'materia_prima_44_cantidad', 'materia_prima_45_cantidad', 'materia_prima_46_cantidad',
        'materia_prima_47_cantidad', 'materia_prima_48_cantidad', 'materia_prima_49_cantidad', 'materia_prima_50_cantidad', 'materia_prima_1_contiene', 'materia_prima_2_contiene', 'materia_prima_3_contiene', 'materia_prima_4_contiene',
        'materia_prima_5_contiene', 'materia_prima_6_contiene', 'materia_prima_7_contiene', 'materia_prima_8_contiene', 'materia_prima_9_contiene', 'materia_prima_10_contiene', 'materia_prima_11_contiene', 'materia_prima_12_contiene',
        'materia_prima_13_contiene', 'materia_prima_14_contiene', 'materia_prima_15_contiene', 'materia_prima_16_contiene', 'materia_prima_17_contiene', 'materia_prima_18_contiene', 'materia_prima_19_contiene', 'materia_prima_20_contiene',
        'materia_prima_21_contiene', 'materia_prima_22_contiene', 'materia_prima_23_contiene', 'materia_prima_24_contiene', 'materia_prima_25_contiene', 'materia_prima_26_contiene', 'materia_prima_27_contiene', 'materia_prima_28_contiene',
        'materia_prima_29_contiene', 'materia_prima_30_contiene', 'materia_prima_31_contiene', 'materia_prima_32_contiene', 'materia_prima_33_contiene', 'materia_prima_34_contiene', 'materia_prima_35_contiene',
        'materia_prima_36_contiene', 'materia_prima_37_contiene', 'materia_prima_38_contiene', 'materia_prima_39_contiene', 'materia_prima_40_contiene', 'materia_prima_41_contiene', 'materia_prima_42_contiene', 'materia_prima_43_contiene',
        'materia_prima_44_contiene', 'materia_prima_45_contiene', 'materia_prima_46_contiene', 'materia_prima_47_contiene', 'materia_prima_48_contiene', 'materia_prima_49_contiene', 'materia_prima_50_contiene']]

        lg.info('seleccion')

        #Introducimos los datos en la tabla maestros

    df_completo_ensayos_maestros.to_sql(Tabla_ensayos2, engine, if_exists='append',index=False)

    query = (f"SELECT id_ensayo FROM {Tabla_ensayos2} WHERE informe = '{informe}' and idp = '{idp}' and fecha = '{fecha}' and analista = '{analista}'")
    df_id = pd.read_sql(query,engine)

    lg.info('datos insertados en maestros')

    id_ensayo = df_id['id_ensayo'][0]
    lg.info(id_ensayo)

    #Introducimos los datos en la tabla l_antes si no hay csv_despues

    if not_csv_despues:
        df_completo_ensayos_formulas_sin_cribar.loc[:,'id_ensayo'] = id_ensayo
        lg.info('Entra en df_l_antes')
        df_l_antes.loc[:, 'id_ensayo'] = id_ensayo
        lg.info(df_l_antes)
        df_l_antes.to_sql(Tabla_l_antes, engine, if_exists='append',index=False)
        df_completo_ensayos_formulas_sin_cribar.to_sql(Tabla_formulas_sin_terminadas, engine, if_exists='append',index=False)
    else:
        df_completo_ensayos_formulas_criba.loc[:,'id_ensayo'] = id_ensayo
        df_completo_ensayos_formulas_cribado.loc[:,'id_ensayo'] = id_ensayo
        df_completo_ensayos_formulas_cribado.to_sql(Tabla_formulas_terminadas, engine, if_exists='append',index=False)
        df_completo_ensayos_formulas_criba.to_sql(Tabla_formulas_cribadas, engine, if_exists='append',index=False)

    lg.info('datos insertados en formulas')


    lg.info('fin insertar resultados')


        
        

def insertar_dataset(req_body):

    df = req_body.get('csv')

    if df:

        lista = df['nombre_ensayo'].unique()
        for i in lista:
            ensayo = df[df.nombre_ensayo == i]
            linea = ensayo.iloc[[0]]
            linea.to_sql({Tabla_ensayos2}, engine, if_exists='append',index=False)

    

