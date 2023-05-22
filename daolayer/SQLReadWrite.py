from sqlalchemy import create_engine
from flask import flash
import os 

class SQLReadWrite:
	
	username = os.environ.get('MYSQL_USERNAME')
	password = os.environ.get('MYSQL_PASSWORD')
	host 	 = os.environ.get('MYSQL_HOST', default='localhost')
	database = os.environ.get("MYSQL_DB")
	engine = create_engine(f'mysql+pymysql://{username}:{password}@{host}/{database}')

	@staticmethod
	def execute_query(query, p_tuple=(), get_op = False):
		try:
			with SQLReadWrite.engine.connect() as conn:
				if get_op:
				 	conn.execute(query, p_tuple)
				else: 
					result = conn.execute(query, p_tuple)

			if get_op : return None
			
			list_ =  [dict(row) for row in result.all()]
			
			if len(list_) != 0:
				return list_
			return None
			
		except Exception as e:
			flash(e)
