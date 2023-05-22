from sqlalchemy import create_engine, text
from flask import flash
import os 

class SQLReadWrite:
	
	username = os.environ.get('MYSQL_USERNAME')
	password = os.environ.get('MYSQL_PASSWORD')
	host 	 = os.environ.get('MYSQL_HOST', default='localhost')
	database = os.environ.get("MYSQL_DB")
	engine = create_engine(f'mysql+pymysql://{username}:{password}@{host}/{database}')

	@staticmethod
	def execute_query(query, p_tuple=()):
		try:
			with SQLReadWrite.engine.connect() as conn:
				result = conn.execute(query, p_tuple)
			list_ =  [dict(row) for row in result.all()]
			if len(list_) != 0:
				return list_
			else : 
				return None
		
		except Exception as e:
			flash(e)
