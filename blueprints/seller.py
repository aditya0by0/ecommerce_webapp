from flask import flash, get_flashed_messages
from flask import Blueprint
from flask import redirect
from flask import render_template
from flask import url_for
from flask import request
from flask import session
from flask import g
import sqlite3
from flask import Flask, jsonify

from itertools import groupby

from daolayer.SQLReadWrite import SQLReadWrite

bp = Blueprint("seller", __name__, url_prefix="/seller")

@bp.before_request
def load_logged_in_seller():
	seller_id = session.get("user_id")
	if seller_id is None:
		g.user = None
		flash("Please, Login in with your Seller account")
		return redirect(url_for("auth.login"))
	else:
		result = SQLReadWrite.execute_query("SELECT * FROM sellers WHERE id = %s", (seller_id,))
		if result:
			g.user = result[0]
			g.user['role'] = 'Seller'
		else :
			flash("Please, Login in with your Seller account")
			return redirect(url_for("auth.login"))

@bp.route("/basePage")
def show_seller_page():
	sid = g.user['id']
	result = SQLReadWrite.execute_query('''SELECT * FROM products where pid in (
				SELECT pid from products_sellers where sid = %s)''',(sid,))
	sorted_data = sorted(result, key=lambda x: x['category'])
	grouped_data = groupby(sorted_data, key=lambda x: x['category'])
	seller_data = get_best_seller_name()
	offer_history = get_offer_history()
	return render_template('seller/yourProducts.html', 
		grouped_products=grouped_data,
		grouped_sellers=seller_data,
		offer_history = offer_history
	)

@bp.route("/viewProduct/<int:pid>")
def seller_view_product(pid:int):
	result = SQLReadWrite.execute_query('SELECT * from products where pid=%s', (pid,))
	return render_template('seller/productPage.html', product=result[0])

@bp.route("/create-offer-price/<int:pid>", methods=['POST'])
def add_offered_price(pid:int):
	offerPrice = float(request.form['offerPrice'])
	orgOfferPrice = request.form['offerPrice']
	print(orgOfferPrice, offerPrice)
	# Update the offerPrice
	#TODO: Update the sellerId 
	SQLReadWrite.execute_query(f'INSERT INTO offer_history (`pid`, `sid`, `editor`, `offerPrice`) VALUES({pid}, 1, "Seller", {orgOfferPrice})')
	SQLReadWrite.execute_query('UPDATE products SET offerPrice = %s WHERE pid = %s',
		(offerPrice, pid), True)
	if not get_flashed_messages():
		flash("Offer Created!")
	return redirect(url_for('seller.seller_view_product', pid = pid))

@bp.route("/add-quantity/<int:pid>", methods=['POST'])
def add_quantity(pid:int):
	quantity = int(request.form['quantity'])
	SQLReadWrite.execute_query('UPDATE products SET quantity = quantity + %s WHERE pid = %s',
		(quantity, pid), True)
	if not get_flashed_messages():
		flash("Quantity Added!")
	return redirect(url_for('seller.seller_view_product', pid = pid))

def get_best_seller_name():

	# Execute a query to retrieve the seller names
	query = "SELECT sid, COUNT(*) AS orderCount FROM pycoders.user_history GROUP BY sid;"
	results = SQLReadWrite.execute_query(query)
	orderCount = (results[0]["orderCount"])
	orderSellerId = results[0]["sid"]

	query = f"SELECT name FROM pycoders.sellers WHERE id={orderSellerId}"
	results = SQLReadWrite.execute_query(query)
	sellerName = results
	print(sellerName)
	return sellerName

def get_offer_history():
	query = "SELECT * FROM offer_history ORDER BY id ASC LIMIT 20"
	results = SQLReadWrite.execute_query(query)
	return results
