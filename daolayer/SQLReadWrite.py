from sqlalchemy import create_engine, text
import os 

class SQLReadWrite:
	
	username = os.environ.get('MYSQL_USERNAME')
	password = os.environ.get('MYSQL_PASSWORD')
	host 	 = os.environ.get('MYSQL_HOST', default='localhost')
	database = os.environ.get("MYSQL_DB")
	engine = create_engine(f'mysql+pymysql://{username}:{password}@{host}/{database}')

	@staticmethod
	def execute_query(query, ptuple=()):
		with SQLReadWrite.engine.connect() as conn:
			result = conn.execute(query, ptuple)
		return result