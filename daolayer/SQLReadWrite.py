from sqlalchemy import create_engine, text
import os 

class SQLReadWrite:
	
	username = os.environ.get('MYSQL_USERNAME')
	password = os.environ.get('MYSQL_PASSWORD')
	host 	 = os.environ.get('MYSQL_HOST', default='localhost')
	database = os.environ.get("MYSQL_DB")
	engine = create_engine(f'mysql+pymysql://{username}:{password}@{host}/{database}')

	@staticmethod
	def put_data(table_name, **kwargs):

		try:
			string = "insert into " + table_name + str(tuple(kwargs.keys())) + \
			 		 ' values ' + str(tuple(kwargs.values()))

			print(string)

			with SQLReadWrite.engine.connect() as conn:
				result = conn.execute(text(string))
		except Exception as e:
			# raise "Date Insert operation failed"
			return False
		else:
			return True

		
	@staticmethod
	def check_if_exists(table_name, **kwargs):
		
		list_ = SQLReadWrite.get_data(table_name, **kwargs)
		if len(list_) != 0:
			return True
		
		return False 

	@staticmethod
	def get_data(table_name, **kwargs):
		result_dict=[]
		string = "select * from " + table_name

		if kwargs :
			string += ' where'
			for key in ['field', 'operator', 'value']:
				if key not in kwargs: 
					raise 'All parameters not supplied'
				if key == 'value' :
					string += " '" + kwargs[key] + "'"
					continue
				string += ' ' + kwargs[key]

		print(string)
				 
		with SQLReadWrite.engine.connect() as conn:
			result = conn.execute(text(string))
		
		return [dict(row) for row in result.all()]

	@staticmethod
	def read_data():
		pass

	@staticmethod
	def delete_data():
		pass
