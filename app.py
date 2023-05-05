from flask import Flask, render_template, request
from daolayer.SQLReadWrite import SQLReadWrite

app = Flask(__name__)

@app.route("/")
def get_home_page():
	return render_template("home.html")

@app.route("/product")
def get_product_page():
	return render_template("product_details.html")

@app.route("/signup", methods=['GET'])
def signup_get():
	return render_template("signupPage.html")

@app.route("/signup", methods=['POST'])
def signup_post():
	
	name = request.form['name']
	email = request.form['email']
	password = request.form['password']

	if SQLReadWrite.check_if_exists('users', field='email', operator='=', value=email ):
		return 'User already exist with registered email id'

	if SQLReadWrite.put_data('users', name=name, email=email, password=password):
		return " registered sucessfully"
	else:
		return " An error occured" 



@app.route("/login")
def login():
	return render_template("loginPage.html")

@app.route("/test")
def test():
	return render_template("test.html")


if __name__ == "__main__":
	app.run(host="0.0.0.0", debug=True)