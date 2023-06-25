from sqlalchemy import create_engine
from flask import flash
import os 
from sqlalchemy.exc import IntegrityError

class SQLReadWrite:
	
	username = os.environ.get('MYSQL_USERNAME')
	password = os.environ.get('MYSQL_PASSWORD')
	host 	 = os.environ.get('MYSQL_HOST', default='localhost')
	database = os.environ.get("MYSQL_DB")
	engine = create_engine(f'mysql+pymysql://{username}:{password}@{host}/{database}')

	@staticmethod
	def execute_query(query, p_tuple=(), put_op = False):
		'''
		Put operation = True : Only for INSERT/UPDATE/DELETE queries
		Put operation = False : Only for READ queries
		'''
		try:
			with SQLReadWrite.engine.connect() as conn:
				if put_op:
					 conn.execute(query, p_tuple)
				else: 
					result = conn.execute(query, p_tuple)

			if put_op : return None
			
			list_ =  [dict(row) for row in result.all()]
			
			if len(list_) != 0:
				return list_
			return None

		except IntegrityError as ie:
			raise ie

		except Exception as e:
			flash(str(e))
