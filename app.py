from flask import Flask, render_template, request
from daolayer.SQLReadWrite import SQLReadWrite
import auth

app = Flask(__name__, template_folder='templates')
app.register_blueprint(auth.bp)

@app.route("/", methods=['GET'])
def get_home_page():
	return render_template("home.html")

@app.route("/product/<p_id>", methods=['POST'])
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



if __name__ == "__main__":
	app.run(host="0.0.0.0", debug=True)