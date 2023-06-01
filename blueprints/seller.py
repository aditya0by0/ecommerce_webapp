from daolayer.SQLReadWrite import SQLReadWrite

from itertools import groupby
from flask import flash, get_flashed_messages
from flask import Blueprint
from flask import redirect
from flask import render_template
from flask import url_for
from flask import request


bp = Blueprint("seller", __name__, url_prefix="/seller")

@bp.route("/basePage/<int:sid>")
def show_seller_page(sid:int):
	result = SQLReadWrite.execute_query('''SELECT * FROM products where pid in (
				SELECT pid from products_sellers where sid = %s)''',(sid,))
	sorted_data = sorted(result, key=lambda x: x['category'])
	grouped_data = groupby(sorted_data, key=lambda x: x['category'])
	return render_template('seller/yourProducts.html', grouped_products=grouped_data)

@bp.route("/viewProduct/<int:pid>")
def seller_view_product(pid:int):
	result = SQLReadWrite.execute_query('SELECT * from products where pid=%s', (pid,))
	return render_template('seller/productPage.html', product=result[0])

@bp.route("/create-offer-price/<int:pid>", methods=['POST'])
def add_offered_price(pid:int):
	offerPrice = float(request.form['offerPrice'])
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