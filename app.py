from flask import Flask
from flask import render_template
from flask import request
from flask import g
from flask import redirect
from flask import url_for
from flask import flash
from flask import session

import os

from daolayer.SQLReadWrite import SQLReadWrite
from blueprints import auth, seller, user, chat

app = Flask(__name__, template_folder='templates')
app.register_blueprint(auth.bp)
app.register_blueprint(seller.bp)
app.register_blueprint(user.bp)
app.register_blueprint(chat.bp)

app.secret_key = 'isee_project_ecomm'

app_dir = os.path.dirname(os.path.abspath(__file__))  

# Path to upload offer's images 
OFFERS_UPLOAD_FOLDER = os.path.join(app_dir, 'static', 'images', 'offers')
app.config['OFFERS_UPLOAD_FOLDER'] = OFFERS_UPLOAD_FOLDER

# Path to upload product's image
PRODUCTS_UPLOAD_FOLDER = os.path.join(app_dir, 'static', 'images', 'products')
app.config['PRODUCTS_UPLOAD_FOLDER'] = PRODUCTS_UPLOAD_FOLDER

# Check if user is logged in OR seller, and assign the role
@app.before_request
def load_logged_in_user():
	user_id = session.get("user_id")
	role = session.get("role")
	if user_id is None:
		g.user = None
	else:
		if role == 'User':
			result = SQLReadWrite.execute_query("SELECT * FROM users WHERE id = %s", (user_id,))
			g.user = result[0]
			g.user['role'] = 'User'

		elif role == 'Seller':
			result = SQLReadWrite.execute_query("SELECT * FROM sellers WHERE id = %s", (user_id,))
			g.user = result[0]
			g.user['role'] = 'Seller'

# Give signed user as input parameter to every page 
@app.context_processor
def inject_user_name():
	def get_user_name():
		if g.user:
			return g.user
		return None

	return {'user_signed': get_user_name()}

# Home Page
@app.route("/", methods=['GET'])
def get_home_page():
	result = SQLReadWrite.execute_query('''SELECT p.* FROM products p
		WHERE (p.category, p.pid) IN (SELECT category, min(pid) FROM products
  		GROUP BY category)''')
	return render_template("home.html", categories_p=result)

# Get Product Page
@app.route("/product/<int:p_id>")
def get_product_page(p_id: int):
	result = SQLReadWrite.execute_query('SELECT * from products where pid=%s', (p_id))
	ratings = SQLReadWrite.execute_query('SELECT * from ratings WHERE pid=%s', (p_id))
	finalRating = 0
	if ratings:
		for rating in ratings:
			finalRating += float(rating["rating"])

		finalRating = format(float(finalRating / len(ratings)), '.2f')
	else:
		finalRating = "No ratings!"

	return render_template("products/productDetails.html", product=result[0], rating=finalRating)

# Get Searched products
@app.route("/search", methods=['POST'])
def search():
	searched = request.form['searched'].lower()

	with SQLReadWrite.engine.connect() as conn:
		result = conn.execute('''SELECT p.*, s.isPremium,
			cast((( (p.price - p.offerPrice) / p.price ) * 100) AS SIGNED) AS "discount" 
			FROM products p
			JOIN products_sellers ps ON ps.pid = p.pid
			JOIN sellers s ON s.id = ps.sid
			WHERE pName LIKE %s ORDER BY discount DESC''',
			('%'+searched+'%',))
	
	result_dict = [dict(row) for row in result.all()]
	return render_template('search.html', searched=searched , products = result_dict)

# Product Categories Page
@app.route("/category")
@app.route("/category/<cname>")
def show_categories(cname=None):
	products = []
	if cname is not None:
		products = SQLReadWrite.execute_query('''SELECT p.*,s.isPremium,
			cast((( (p.price - p.offerPrice) / p.price ) * 100) AS SIGNED) AS "discount" 
			FROM products p
			JOIN products_sellers ps ON ps.pid = p.pid
			JOIN sellers s ON s.id = ps.sid
			WHERE category = %s ORDER BY discount DESC;''',
			(cname,))
		print(products)
	result = SQLReadWrite.execute_query("SELECT distinct category from products")
	return render_template('categories.html', categories = result, 
		products=products, c_name=cname)

# Only for Testing - Please ignore 
@app.route("/test")
def test():
	return render_template('../ecom_requirments.html', zip=zip)

if __name__ == "__main__":
	app.run(host="0.0.0.0", debug=True)