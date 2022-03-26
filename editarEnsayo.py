import logging as lg
import pyodbc
import sqlalchemy
import azure.functions as func
import pandas as pd
from io import StringIO
import numpy as np
import pathlib as pl

import os

Driver = os.environ["DRIVER"]
Server = os.environ["SERVER"]
Port = os.environ["PORT"]
Database = os.environ["DATABASE"]
Uid = os.environ["UID"]
Pwd = os.environ["PWD"]
Tabla_ensayos = os.environ["TABLA_ENSAYOS"]
Tabla_ensayos2 = os.environ["TABLA_ENSAYOS_2"]
Tabla_manchas = os.environ["TABLA_MANCHAS"]
Tabla_lavadora = os.environ["TABLA_LAVADORAS"]
Tabla_instrumentos = os.environ["TABLA_INSTRUMENTOS"]  
Tabla_l_antes = os.environ["TABLA_L_ANTES"]
Tabla_formulas_terminadas = os.environ["TABLA_FORMULAS"]
Tabla_formulas_sin_terminadas = os.environ["TABLA_FORMULAS_INACABADAS"]
Tabla_formulas_cribadas = os.environ["TABLA_CRIBA"]

columnas_tabla = {
    'Detergencia': 'detergencia',
    'tipo_mancha': 'nombre_mancha',
    'detergencia_y': 'detergencia',
    'Suciedad': 'mancha',
    'mancha_y': 'mancha'
}

def large(arr, media):

    #root element varible 
    max_ = arr[0]
    
    for ele in arr:
        if(np.absolute(ele-media) > np.absolute(max_-media)):
           max_ = ele

    # print('detergencia a eliminar: ', max_)
    return max_



engine = sqlalchemy.create_engine(f'mssql+pyodbc://{Uid}:{Pwd}@{Server}:{str(Port)}/{Database}?driver={Driver}', echo = True)

def editar_ensayo(req_body):

    csv_despues = req_body.get('csv_despues')
    csv_correccion_despues = req_body.get('csv_correccion_despues')
    id_ensayo = req_body.get('id_ensayo')

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

    ciclos = req_body.get('ciclo')

    antecedentes = req_body.get('antecedentes')
    conclusiones = req_body.get('conclusiones')


    sql_ensayos = (f"SELECT ensayo_terminado FROM {Tabla_ensayos2} WHERE id_ensayo = '{id_ensayo}'")
    df_ensayo = pd.read_sql(sql_ensayos, engine)

    sql_update_maestro = f"UPDATE {Tabla_ensayos2} SET nombre_ensayo = '{nombre_ensayo}', idp = '{idp}', fecha = '{fecha}', temperatura = '{temperatura}', dureza_agua = '{dureza_agua}', lavadora = '{lavadora}', analista = '{analista}', instrumento_lectura = '{instrumento_lectura}', replicados = '{replicados}', peticionario = '{peticionario}', informe = '{informe}', set_manchas = '{set_manchas}', ciclos = '{ciclos}', antecedentes = '{antecedentes}', conclusiones = '{conclusiones}'  WHERE id_ensayo = '{id_ensayo}'"

    with engine.connect() as conn:
            conn.execute(sql_update_maestro)

    ensayo_terminado = df_ensayo['ensayo_terminado'][0]

    

    #Rellenar tabla formulas sustituyendo

    lg.info('Antes formulas')

    for i in range(1,int(numero_formulas)+1):

        if ensayo_terminado == 0:
            sql_update_formulas = (f"UPDATE {Tabla_formulas_sin_terminadas} ")
        else:
            sql_update_formulas = (f"UPDATE {Tabla_formulas_terminadas} ")
        lg.info('Entra en el for')

        detergente = req_body.get('detergente'+str(i))
        lg.info(detergente)
        nombre_formula = detergente['nombre_formula']
        categoria = detergente['categoria']
        dosificaciones_g = detergente['dosificacion_g']
        dosificaciones_ml = detergente['dosificacion_ml']
        densidad = detergente['densidad']
        ph = detergente['ph']
        patron = 0 if detergente['patron'] == 'False' else 1

        lg.info('Lee datos generales')

        materia_prima_1_cantidad = detergente['materia_prima_1_cantidad'] 
        materia_prima_1_contiene = 0 if detergente['materia_prima_1_contiene'] == 'False' else 1
        materia_prima_2_cantidad = detergente['materia_prima_2_cantidad']
        materia_prima_2_contiene = 0 if detergente['materia_prima_2_contiene'] == 'False' else 1
        materia_prima_3_cantidad = detergente['materia_prima_3_cantidad']
        materia_prima_3_contiene = 0 if detergente['materia_prima_3_contiene'] == 'False' else 1
        materia_prima_4_cantidad = detergente['materia_prima_4_cantidad']
        materia_prima_4_contiene = 0 if detergente['materia_prima_4_contiene'] == 'False' else 1
        materia_prima_5_cantidad = detergente['materia_prima_5_cantidad']
        materia_prima_5_contiene = 0 if detergente['materia_prima_5_contiene'] == 'False' else 1
        materia_prima_6_cantidad = detergente['materia_prima_6_cantidad']
        materia_prima_6_contiene = 0 if detergente['materia_prima_6_contiene'] == 'False' else 1
        materia_prima_7_cantidad = detergente['materia_prima_7_cantidad']
        materia_prima_7_contiene = 0 if detergente['materia_prima_7_contiene'] == 'False' else 1
        materia_prima_8_cantidad = detergente['materia_prima_8_cantidad']
        materia_prima_8_contiene = 0 if detergente['materia_prima_8_contiene'] == 'False' else 1
        materia_prima_9_cantidad = detergente['materia_prima_9_cantidad']
        materia_prima_9_contiene = 0 if detergente['materia_prima_9_contiene'] == 'False' else 1
        materia_prima_10_cantidad = detergente['materia_prima_10_cantidad']
        materia_prima_10_contiene = 0 if detergente['materia_prima_10_contiene'] == 'False' else 1
        materia_prima_11_cantidad = detergente['materia_prima_11_cantidad']
        materia_prima_11_contiene = 0 if detergente['materia_prima_11_contiene'] == 'False' else 1
        materia_prima_12_cantidad = detergente['materia_prima_12_cantidad']
        materia_prima_12_contiene = 0 if detergente['materia_prima_12_contiene'] == 'False' else 1
        materia_prima_13_cantidad = detergente['materia_prima_13_cantidad']
        materia_prima_13_contiene = 0 if detergente['materia_prima_13_contiene'] == 'False' else 1
        materia_prima_14_cantidad = detergente['materia_prima_14_cantidad']
        materia_prima_14_contiene = 0 if detergente['materia_prima_14_contiene'] == 'False' else 1
        materia_prima_15_cantidad = detergente['materia_prima_15_cantidad']
        materia_prima_15_contiene = 0 if detergente['materia_prima_15_contiene'] == 'False' else 1
        materia_prima_16_cantidad = detergente['materia_prima_16_cantidad']
        materia_prima_16_contiene = 0 if detergente['materia_prima_16_contiene'] == 'False' else 1
        materia_prima_17_cantidad = detergente['materia_prima_17_cantidad']
        materia_prima_17_contiene = 0 if detergente['materia_prima_17_contiene'] == 'False' else 1
        materia_prima_18_cantidad = detergente['materia_prima_18_cantidad']
        materia_prima_18_contiene = 0 if detergente['materia_prima_18_contiene'] == 'False' else 1
        materia_prima_19_cantidad = detergente['materia_prima_19_cantidad']
        materia_prima_19_contiene = 0 if detergente['materia_prima_19_contiene'] == 'False' else 1
        materia_prima_20_cantidad = detergente['materia_prima_20_cantidad']
        materia_prima_20_contiene = 0 if detergente['materia_prima_20_contiene'] == 'False' else 1
        materia_prima_21_cantidad = detergente['materia_prima_21_cantidad']
        materia_prima_21_contiene = 0 if detergente['materia_prima_21_contiene'] == 'False' else 1
        materia_prima_22_cantidad = detergente['materia_prima_22_cantidad']
        materia_prima_22_contiene = 0 if detergente['materia_prima_22_contiene'] == 'False' else 1
        materia_prima_23_cantidad = detergente['materia_prima_23_cantidad']
        materia_prima_23_contiene = 0 if detergente['materia_prima_23_contiene'] == 'False' else 1
        materia_prima_24_cantidad = detergente['materia_prima_24_cantidad']
        materia_prima_24_contiene = 0 if detergente['materia_prima_24_contiene'] == 'False' else 1
        materia_prima_25_cantidad = detergente['materia_prima_25_cantidad']
        materia_prima_25_contiene = 0 if detergente['materia_prima_25_contiene'] == 'False' else 1
        materia_prima_26_cantidad = detergente['materia_prima_26_cantidad']
        materia_prima_26_contiene = 0 if detergente['materia_prima_26_contiene'] == 'False' else 1
        materia_prima_27_cantidad = detergente['materia_prima_27_cantidad']
        materia_prima_27_contiene = 0 if detergente['materia_prima_27_contiene'] == 'False' else 1
        materia_prima_28_cantidad = detergente['materia_prima_28_cantidad']
        materia_prima_28_contiene = 0 if detergente['materia_prima_28_contiene'] == 'False' else 1
        materia_prima_29_cantidad = detergente['materia_prima_29_cantidad']
        materia_prima_29_contiene = 0 if detergente['materia_prima_29_contiene'] == 'False' else 1
        materia_prima_30_cantidad = detergente['materia_prima_30_cantidad']
        materia_prima_30_contiene = 0 if detergente['materia_prima_30_contiene'] == 'False' else 1
        materia_prima_31_cantidad = detergente['materia_prima_31_cantidad']
        materia_prima_31_contiene = 0 if detergente['materia_prima_31_contiene'] == 'False' else 1
        materia_prima_32_cantidad = detergente['materia_prima_32_cantidad']
        materia_prima_32_contiene = 0 if detergente['materia_prima_32_contiene'] == 'False' else 1
        materia_prima_33_cantidad = detergente['materia_prima_33_cantidad']
        materia_prima_33_contiene = 0 if detergente['materia_prima_33_contiene'] == 'False' else 1
        materia_prima_34_cantidad = detergente['materia_prima_34_cantidad']
        materia_prima_34_contiene = 0 if detergente['materia_prima_34_contiene'] == 'False' else 1
        materia_prima_35_cantidad = detergente['materia_prima_35_cantidad']
        materia_prima_35_contiene = 0 if detergente['materia_prima_35_contiene'] == 'False' else 1
        materia_prima_36_cantidad = detergente['materia_prima_36_cantidad']
        materia_prima_36_contiene = 0 if detergente['materia_prima_36_contiene'] == 'False' else 1
        materia_prima_37_cantidad = detergente['materia_prima_37_cantidad']
        materia_prima_37_contiene = 0 if detergente['materia_prima_37_contiene'] == 'False' else 1
        materia_prima_38_cantidad = detergente['materia_prima_38_cantidad']
        materia_prima_38_contiene = 0 if detergente['materia_prima_38_contiene'] == 'False' else 1
        materia_prima_39_cantidad = detergente['materia_prima_39_cantidad']
        materia_prima_39_contiene = 0 if detergente['materia_prima_39_contiene'] == 'False' else 1
        materia_prima_40_cantidad = detergente['materia_prima_40_cantidad']
        materia_prima_40_contiene = 0 if detergente['materia_prima_40_contiene'] == 'False' else 1
        lg.info('llega aqui')
        materia_prima_41_cantidad = detergente['materia_prima_41_cantidad']
        materia_prima_41_contiene = 0 if detergente['materia_prima_41_contiene'] == 'False' else 1
        materia_prima_42_cantidad = detergente['materia_prima_42_cantidad']
        materia_prima_42_contiene = 0 if detergente['materia_prima_42_contiene'] == 'False' else 1
        materia_prima_43_cantidad = detergente['materia_prima_43_cantidad']
        materia_prima_43_contiene = 0 if detergente['materia_prima_43_contiene'] == 'False' else 1
        materia_prima_44_cantidad = detergente['materia_prima_44_cantidad']
        materia_prima_44_contiene = 0 if detergente['materia_prima_44_contiene'] == 'False' else 1
        materia_prima_45_cantidad = detergente['materia_prima_45_cantidad']
        materia_prima_45_contiene = 0 if detergente['materia_prima_45_contiene'] == 'False' else 1
        materia_prima_46_cantidad = detergente['materia_prima_46_cantidad']
        materia_prima_46_contiene = 0 if detergente['materia_prima_46_contiene'] == 'False' else 1
        materia_prima_47_cantidad = detergente['materia_prima_47_cantidad']
        materia_prima_47_contiene = 0 if detergente['materia_prima_47_contiene'] == 'False' else 1
        materia_prima_48_cantidad = detergente['materia_prima_48_cantidad']
        materia_prima_48_contiene = 0 if detergente['materia_prima_48_contiene'] == 'False' else 1
        materia_prima_49_cantidad = detergente['materia_prima_49_cantidad']
        materia_prima_49_contiene = 0 if detergente['materia_prima_49_contiene'] == 'False' else 1
        materia_prima_50_cantidad = detergente['materia_prima_50_cantidad']
        materia_prima_50_contiene = 0 if detergente['materia_prima_50_contiene'] == 'False' else 1
        lg.info('llega aqui')

        sql_update_formulas = (f"{sql_update_formulas} SET nombre_formula = '{nombre_formula}', categoria = '{categoria}', dosificacion_ml = '{dosificaciones_ml}', dosificacion_g = '{dosificaciones_g}', densidad = '{densidad}', ph = '{ph}', patron = '{patron}', materia_prima_1_contiene = '{materia_prima_1_contiene}', materia_prima_1_cantidad = '{materia_prima_1_cantidad}', materia_prima_2_contiene = '{materia_prima_2_contiene}', materia_prima_2_cantidad = '{materia_prima_2_cantidad}', materia_prima_3_contiene = '{materia_prima_3_contiene}',materia_prima_3_cantidad = '{materia_prima_3_cantidad}', materia_prima_4_contiene = '{materia_prima_4_contiene}', materia_prima_4_cantidad = '{materia_prima_4_cantidad}', materia_prima_5_contiene = '{materia_prima_5_contiene}', materia_prima_5_cantidad = '{materia_prima_5_cantidad}', materia_prima_6_contiene = '{materia_prima_6_contiene}', materia_prima_6_cantidad = '{materia_prima_6_cantidad}', materia_prima_7_contiene = '{materia_prima_7_contiene}', materia_prima_7_cantidad = '{materia_prima_7_cantidad}', materia_prima_8_contiene = '{materia_prima_8_contiene}', materia_prima_8_cantidad = '{materia_prima_8_cantidad}', materia_prima_9_contiene = '{materia_prima_9_contiene}', materia_prima_9_cantidad = '{materia_prima_9_cantidad}',materia_prima_10_contiene = '{materia_prima_10_contiene}',materia_prima_10_cantidad = '{materia_prima_10_cantidad}',   materia_prima_11_contiene = '{materia_prima_11_contiene}',materia_prima_11_cantidad = '{materia_prima_11_cantidad}',materia_prima_12_contiene = '{materia_prima_12_contiene}',materia_prima_12_cantidad = '{materia_prima_12_cantidad}',materia_prima_13_contiene = '{materia_prima_13_contiene}',materia_prima_13_cantidad = '{materia_prima_13_cantidad}',materia_prima_14_contiene = '{materia_prima_14_contiene}',materia_prima_14_cantidad = '{materia_prima_14_cantidad}',materia_prima_15_contiene = '{materia_prima_15_contiene}',materia_prima_15_cantidad = '{materia_prima_15_cantidad}',materia_prima_16_contiene = '{materia_prima_16_contiene}',materia_prima_16_cantidad = '{materia_prima_16_cantidad}',materia_prima_17_contiene = '{materia_prima_17_contiene}',materia_prima_17_cantidad = '{materia_prima_17_cantidad}',materia_prima_18_contiene = '{materia_prima_18_contiene}',materia_prima_18_cantidad = '{materia_prima_18_cantidad}',materia_prima_19_contiene = '{materia_prima_19_contiene}',materia_prima_19_cantidad = '{materia_prima_19_cantidad}', materia_prima_20_contiene = '{materia_prima_20_contiene}',materia_prima_20_cantidad = '{materia_prima_20_cantidad}', materia_prima_21_contiene = '{materia_prima_21_contiene}',materia_prima_21_cantidad = '{materia_prima_21_cantidad}',materia_prima_22_contiene = '{materia_prima_22_contiene}',materia_prima_22_cantidad = '{materia_prima_22_cantidad}',materia_prima_23_contiene = '{materia_prima_23_contiene}',materia_prima_23_cantidad = '{materia_prima_23_cantidad}',materia_prima_24_contiene = '{materia_prima_24_contiene}',materia_prima_24_cantidad = '{materia_prima_24_cantidad}',materia_prima_25_contiene = '{materia_prima_25_contiene}',materia_prima_25_cantidad = '{materia_prima_25_cantidad}',materia_prima_26_contiene = '{materia_prima_26_contiene}',materia_prima_26_cantidad = '{materia_prima_26_cantidad}',materia_prima_27_contiene = '{materia_prima_27_contiene}',materia_prima_27_cantidad = '{materia_prima_27_cantidad}',materia_prima_28_contiene = '{materia_prima_28_contiene}',materia_prima_28_cantidad = '{materia_prima_28_cantidad}',materia_prima_29_contiene = '{materia_prima_29_contiene}',materia_prima_29_cantidad = '{materia_prima_29_cantidad}',materia_prima_30_contiene = '{materia_prima_30_contiene}',materia_prima_30_cantidad = '{materia_prima_30_cantidad}', materia_prima_31_contiene = '{materia_prima_31_contiene}',materia_prima_31_cantidad = '{materia_prima_31_cantidad}',materia_prima_32_contiene = '{materia_prima_32_contiene}',materia_prima_32_cantidad = '{materia_prima_32_cantidad}',materia_prima_33_contiene = '{materia_prima_33_contiene}',materia_prima_33_cantidad = '{materia_prima_33_cantidad}',materia_prima_34_contiene = '{materia_prima_34_contiene}',materia_prima_34_cantidad = '{materia_prima_34_cantidad}',materia_prima_35_contiene = '{materia_prima_35_contiene}',materia_prima_35_cantidad = '{materia_prima_35_cantidad}',materia_prima_36_contiene = '{materia_prima_36_contiene}',materia_prima_36_cantidad = '{materia_prima_36_cantidad}',materia_prima_37_contiene = '{materia_prima_37_contiene}',materia_prima_37_cantidad = '{materia_prima_37_cantidad}',materia_prima_38_contiene = '{materia_prima_38_contiene}',materia_prima_38_cantidad = '{materia_prima_38_cantidad}',materia_prima_39_contiene = '{materia_prima_39_contiene}',materia_prima_39_cantidad = '{materia_prima_39_cantidad}',materia_prima_40_contiene = '{materia_prima_40_contiene}',materia_prima_40_cantidad = '{materia_prima_40_cantidad}',materia_prima_41_contiene = '{materia_prima_41_contiene}',materia_prima_41_cantidad = '{materia_prima_41_cantidad}',materia_prima_42_contiene = '{materia_prima_42_contiene}',materia_prima_42_cantidad = '{materia_prima_42_cantidad}',materia_prima_43_contiene = '{materia_prima_43_contiene}',materia_prima_43_cantidad = '{materia_prima_43_cantidad}',materia_prima_44_contiene = '{materia_prima_44_contiene}',materia_prima_44_cantidad = '{materia_prima_44_cantidad}',materia_prima_45_contiene = '{materia_prima_45_contiene}',materia_prima_45_cantidad = '{materia_prima_45_cantidad}',materia_prima_46_contiene = '{materia_prima_46_contiene}',materia_prima_46_cantidad = '{materia_prima_46_cantidad}',materia_prima_47_contiene = '{materia_prima_47_contiene}',materia_prima_47_cantidad = '{materia_prima_47_cantidad}',materia_prima_48_contiene = '{materia_prima_48_contiene}',materia_prima_48_cantidad = '{materia_prima_48_cantidad}',materia_prima_49_contiene = '{materia_prima_49_contiene}',materia_prima_49_cantidad = '{materia_prima_49_cantidad}',materia_prima_50_contiene = '{materia_prima_50_contiene}',materia_prima_50_cantidad = '{materia_prima_50_cantidad}' WHERE id_ensayo = '{id_ensayo}' AND n_formula = '{i}'")        
        lg.info(sql_update_formulas)
        with engine.connect() as conn:
            conn.execute(sql_update_formulas)
        sql_update_formulas = ''

    if csv_despues:

        df_set_manchas = pd.read_sql(f"SELECT set_manchas FROM {Tabla_ensayos2} WHERE id_ensayo = '{id_ensayo}'", engine)
        set_manchas = df_set_manchas['set_manchas'][0]
        dict_maestros = pd.read_sql(f"SELECT Suciedad, tipo_mancha, Naturaleza, Soporte, Posicion, Blancos FROM {Tabla_manchas} WHERE set_manchas = '{set_manchas}'", engine)
        lg.info(dict_maestros)
        lg.info('Leo l_antes')
        df_antes_final = pd.read_sql(f"SELECT l_antes, id, Monitor FROM {Tabla_l_antes} WHERE id_ensayo = '{id_ensayo}' ORDER BY Monitor, id ", engine)
        lg.info(df_antes_final)

        csv_despues = StringIO(csv_despues)
        df_despues = pd.read_csv(csv_despues, sep=',', names= ['No','Name','L_despues','a','b','Nada'],header=0)
        df_despues.loc[:,'Monitor'] = df_despues['Name'].str.split('-').str[0]
        # df_despues.loc[:,'Monitor'] = df_despues['Monitor'].str.replace('.', '')
        df_despues.loc[:,'Monitor'] = df_despues['Monitor'].str.replace('.', '').astype('int')
        #df_despues.loc[:,'id'] = df_despues['Name'].str.split('-').str[1]
        df_despues['id'] = df_despues.groupby(['Monitor']).cumcount()+1
        df_despues_final = df_despues[['Monitor','id','L_despues']].copy()
        

        # Mergeo de antes con despues sin correccion
        lg.info('Merge antes/despues')
        df_completo_sin_correccion = df_antes_final.merge(df_despues_final, on=['Monitor','id'],how='left')

        if csv_correccion_despues:
            csv_correccion = StringIO(csv_correccion_despues)
            df_despues_cor = pd.read_csv(csv_correccion, sep=',', names= ['No','Name','L_despues_cor','a','b','Nada'],header=0)
            df_despues_cor.loc[:,'Monitor'] = df_despues_cor['Name'].str.split('-').str[0]
            # df_despues_cor.loc[:,'Monitor'] = df_despues_cor['Monitor'].str.replace('.', '')
            df_despues_cor.loc[:,'Monitor'] = df_despues_cor['Monitor'].str.replace('.', '').astype('int')
            df_despues_cor['id'] = df_despues_cor.groupby(['Monitor']).cumcount()+1
            df_despues_cor_final = df_despues_cor[['Monitor','id','L_despues_cor']].copy()

            #Mergeo el completo sin correccion con la correccion
            df_completo = df_completo_sin_correccion.merge(df_despues_cor_final, on=['Monitor','id'],how='left')

            df_completo.loc[~df_completo['L_despues_cor'].isna(), 'L_despues'] = df_completo['L_despues_cor']
        else:
            df_completo = df_completo_sin_correccion.copy()
        
        lg.info('Mergeado y seguimos')
        df_completo.loc[:,'Posicion'] = df_completo['id']

        df_completo.loc[(df_completo['Monitor'].astype('int64')%2)==0, 'Posicion'] = df_completo['id']+(int(dict_maestros.shape[0]/2))

        df_completo_maestros = df_completo.merge(dict_maestros, on='Posicion', how='left')

        df_completo_maestros.loc[:, 'Detergencia'] = ((df_completo_maestros['L_despues']-df_completo_maestros['l_antes'])/(df_completo_maestros['Blancos']-df_completo_maestros['l_antes']))*100
        df_completo_maestros.fillna(0, inplace=True)
        lg.info('n_formula')
        df_completo_maestros.loc[:,'n_formula'] = df_completo_maestros['Monitor'].astype('float64')/(int(replicados)*2)
        lg.info('replicados')
        df_completo_maestros.loc[:,'n_formula'] = np.ceil(df_completo_maestros['n_formula'])
        lg.info('df_completo_maestros')
        lg.info(df_completo_maestros)
        factor_replicados = len(df_completo_maestros)/int(numero_formulas)/int(replicados)
        lista_replicas = list()
        for formula in range(1,numero_formulas+1):
            for replicado in range(1,int(replicados)+1):
                for i in range(int(factor_replicados)):
                    lista_replicas.append(replicado)
        df_completo_maestros.loc[:, 'replicado'] = lista_replicas
        detergencia = df_completo_maestros[['Detergencia', 'tipo_mancha', 'n_formula', 'replicado', 'Suciedad', 'Posicion']]
        detergencia = detergencia.rename(columns=columnas_tabla)
        query = (f"SELECT * FROM {Tabla_formulas_sin_terminadas} WHERE id_ensayo = '{id_ensayo}'")
        df = pd.read_sql(query, engine)

        lg.info('df')
        lg.info(df)
        lg.info('Merge con detergencia')
        # df = df.merge(detergencia, on=['nombre_mancha','n_formula','replicado'], how='left')

        df[ 'n_formula'] = df[ 'n_formula'].astype('int')
        df[ 'detergencia'] = df[ 'detergencia'].astype('float')
        df.loc[:, 'Posicion'] = 0
        for i in range(detergencia['detergencia'].size):
            indice = df.index[(df.nombre_mancha == detergencia.nombre_mancha[i]) & (df.n_formula == detergencia.n_formula[i]) & (df.replicado == detergencia.replicado[i])]
            df.loc[indice, 'detergencia'] = detergencia['detergencia'][i]
            df.loc[indice, 'Posicion'] = detergencia['Posicion'][i]
        index_detergencia = df.index[df['nombre_mancha'] == 'VACIO'] 
        df.drop(index_detergencia, inplace=True)
        df = df.sort_values(['n_formula', 'replicado','Posicion'])
        df.fillna(0, inplace=True)

        data = []
        datacribada = []
        datamanchas = []
        for formula in range(1, numero_formulas + 1):
            detergencias = list()
            for replicado in range(1, int(replicados) + 1):
                index_formula = (df['n_formula'].astype('int64')==formula) & (df['replicado'].astype('int64')==replicado)
                df_formula = df[index_formula][['detergencia']].fillna(0)
                manchas = df_formula['detergencia'].to_numpy()
                detergencias.append(manchas.tolist())
                datamanchas.append(df[index_formula].fillna(0))

            lista_manchas = datamanchas[0]['nombre_mancha'].tolist()
            for row in range(0, len(detergencias[0])):
                mancha = lista_manchas[row] #string nombre mancha
                if mancha != 'VACIO':
                    array_detergencia = []
                    for rep in range(0, int(replicados)):
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
                                for r in range(0, int(replicados)):
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
                    for r in range(0, int(replicados)):
                        data.append(datamanchas[r].loc[(datamanchas[r].nombre_mancha == mancha) & (datamanchas[r].detergencia != 0)])
                
            # print(len(data))
            datamanchas=[]
        lg.info('Antes concatss')
        df_final = pd.concat(data)
        df_cribado = pd.concat(datacribada)

        lg.info('Despues cribado')

        df_final_insertar = df_final[['id_ensayo','n_formula','replicado','nombre_formula', 'categoria', 'dosificacion_ml', 'dosificacion_g', 'densidad', 'ph', 'mancha', 'nombre_mancha',
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

        df_cribado_insertar = df_cribado[['id_ensayo','n_formula','replicado','nombre_formula', 'categoria', 'dosificacion_ml', 'dosificacion_g', 'densidad', 'ph', 'mancha', 'nombre_mancha',
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



        lg.info('Despues eleccion columnas')


        df_final_insertar.to_sql(Tabla_formulas_terminadas, engine, if_exists='append',index=False)
        df_cribado_insertar.to_sql(Tabla_formulas_cribadas, engine, if_exists='append',index=False)

        sql_update = f"UPDATE {Tabla_ensayos2} SET ensayo_terminado = '1' WHERE id_ensayo = '{id_ensayo}'"
        sql_delete = f"DELETE FROM {Tabla_formulas_sin_terminadas} WHERE id_ensayo = '{id_ensayo}'"
        sql_delete_antes = f"DELETE FROM {Tabla_l_antes} WHERE id_ensayo = '{id_ensayo}'"

        lg.info('Inserciones')


        with engine.connect() as conn:
            conn.execute(sql_update)
            conn.execute(sql_delete)
            conn.execute(sql_delete_antes)

