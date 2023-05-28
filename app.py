from flask import Flask, render_template, request, g
from flask import redirect, url_for
from daolayer.SQLReadWrite import SQLReadWrite
from flask import flash
import auth, seller

app = Flask(__name__, template_folder='templates')
app.register_blueprint(auth.bp)
app.register_blueprint(seller.bp)

app.secret_key = 'isee_project_ecomm'

# @app.before_request
# def before_request():
# 	auth.load_logged_in_user()

@app.route("/", methods=['GET'])
def get_home_page():
	user_name = None
	if g.user : 
		user_name = g.user['username']
	return render_template("home.html", user_signed=user_name)

@app.route("/product/<p_id>", methods=['GET'])
def get_product_page(p_id):
	with SQLReadWrite.engine.connect() as conn:
		result = conn.execute('SELECT * from products where pid=%s', (p_id,))
	result_dict = [dict(row) for row in result.all()][0]
	return render_template("products/productDetails.html",product = result_dict)

@app.route("/search", methods=['POST'])
def search():
	searched = request.form['searched']
	with SQLReadWrite.engine.connect() as conn:
		result = conn.execute('SELECT * from products where category LIKE %s',
								('%'+searched+'%',))
	result_dict = [dict(row) for row in result.all()]
	return render_template('search.html', searched=searched , products = result_dict)

@app.route("/buy/<p_id>")
@auth.login_required
def buy_product(p_id):
	SQLReadWrite.execute_query('UPDATE products SET sold = 1 where pid = %s',
		(p_id,))
	return redirect(url_for(buy_product))

@app.route("/test")
def test():
	return render_template('seller/yourProducts.html')

if __name__ == "__main__":
	app.run(host="0.0.0.0", debug=True)