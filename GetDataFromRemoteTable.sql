CREATE OR REPLACE FUNCTION public.GetDataFromRemoteTable (
)
RETURNS SETOF taller.MyDataType AS
$body$
import pyodbc

conn = plpy.execute('select get_coneccion_string() as conn')
coneccion_string = conn[0]['conn']  
conn = pyodbc.connect(coneccion_string)
 
cursor = conn.cursor()
for row in cursor.execute("""SELECT * 
                             from data_table;"""):  
									         
                             yield(row.f_id,row.f_name)
$body$
LANGUAGE 'plpythonu' VOLATILE CALLED ON NULL INPUT SECURITY INVOKER COST 100 ROWS 1000;
