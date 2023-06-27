from flask import Flask
from flask import render_template
from flask import request
from flask import g
from flask import redirect
from flask import url_for
from flask import flash
from flask import session

from daolayer.SQLReadWrite import SQLReadWrite
from blueprints import auth, seller, user

app = Flask(__name__, template_folder='templates')
app.register_blueprint(auth.bp)
app.register_blueprint(seller.bp)
app.register_blueprint(user.bp)

app.secret_key = 'isee_project_ecomm'

@app.before_request
def load_logged_in_user():
	user_id = session.get("user_id")
	role = session.get("role")
	if user_id is None:
		g.user = None
	else:
		if role == 'User':
			result = SQLReadWrite.execute_query("SELECT * FROM users WHERE id = %s",
												(user_id,))
			g.user = result[0]
			g.user['role'] = 'User'

		elif role == 'Seller':
			result = SQLReadWrite.execute_query("SELECT * FROM sellers WHERE id = %s",
												(user_id,))
			g.user = result[0]
			g.user['role'] = 'Seller'

@app.context_processor
def inject_user_name():
	def get_user_name():
		if g.user:
			return g.user
		return None

	return {'user_signed': get_user_name()}

@app.route("/", methods=['GET'])
def get_home_page():
	result = SQLReadWrite.execute_query('''SELECT p.* FROM products p
		WHERE (p.category, p.pid) IN (SELECT category, min(pid) FROM products
  		GROUP BY category)''')
	return render_template("home.html", categories_p=result)

@app.route("/product/<int:p_id>")
def get_product_page(p_id: int):
	# result[0] : for single product as the page is designed for single product display
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

@app.route("/search", methods=['POST'])
def search():
	searched = request.form['searched'].lower()

	with SQLReadWrite.engine.connect() as conn:
		result = conn.execute('SELECT *, cast(round(( `offerPrice` / `price` ) * 100) as int) as `discount` from products where pName LIKE %s order by discount DESC',
								('%'+searched+'%',))
	result_dict = [dict(row) for row in result.all()]
	return render_template('search.html', searched=searched , products = result_dict)

@app.route("/category")
@app.route("/category/<cname>")
def show_categories(cname=None):
	products = []
	if cname is not None:
		products = SQLReadWrite.execute_query("SELECT *,cast(round(( `offerPrice` / `price` ) * 100) as int) as `discount` FROM products where category = %s order by discount DESC;",
			(cname,))
	
	result = SQLReadWrite.execute_query("SELECT distinct category from products")
	return render_template('categories.html', categories = result, 
		products=products, c_name=cname)


@app.route("/test")
def test():
	return render_template('bootstrap/productBought.html', zip=zip)

if __name__ == "__main__":
	app.run(host="0.0.0.0", debug=True)