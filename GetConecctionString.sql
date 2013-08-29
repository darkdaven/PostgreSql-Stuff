CREATE OR REPLACE FUNCTION public.get_coneccion_string (
)
RETURNS text AS
$body$
import ConfigParser 

parser = ConfigParser.SafeConfigParser()

parser.read('/etc/odbc.ini')
section_name = 'sql1'

host =  parser.get(section_name,'host')
port =  parser.get(section_name,'port')
user =  parser.get(section_name,'user')
database =  parser.get(section_name,'database')
password =  parser.get(section_name,'password')
tdsVersion =  parser.get(section_name,'tds version')

return 'DRIVER=FreeTDS;SERVER='+host+';PORT='+port+';DATABASE='+database+';UID='+user+';PWD='+password+';TDS_Version='+tdsVersion+';'
$body$
LANGUAGE 'plpythonu' VOLATILE CALLED ON NULL INPUT SECURITY INVOKER COST 100;
