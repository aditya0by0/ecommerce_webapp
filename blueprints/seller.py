from flask import flash, get_flashed_messages
from flask import Blueprint
from flask import redirect
from flask import render_template
from flask import url_for
from flask import request
from flask import session
from flask import g
from flask import Flask, jsonify
from flask import current_app

import os
import sqlite3
from itertools import groupby
from werkzeug.utils import secure_filename

from daolayer.SQLReadWrite import SQLReadWrite

bp = Blueprint("seller", __name__, url_prefix="/seller")

# Authenticate Seller for all the Routes/Api available in this blueprint
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

# After logging as seller, sellers get route to this Seller's Home Page
# Show all products of sellers along with offer history and best seller of month
@bp.route("/basePage")
def show_seller_page():
	sid = g.user['id']
	result = SQLReadWrite.execute_query('''SELECT * FROM products WHERE pid IN (
		SELECT pid FROM products_sellers WHERE sid = %s)''',(sid,))
	if result:
		sorted_data = sorted(result, key=lambda x: x['category'])
		grouped_data = groupby(sorted_data, key=lambda x: x['category'])
	else : 
		grouped_data = None
	seller_data = get_best_seller_name()
	offer_history = SQLReadWrite.execute_query('''SELECT oh.*, p.pName 
        FROM offerHistory oh
        JOIN products p ON p.pid = oh.pid
        WHERE sid =%s ORDER BY id DESC LIMIT 20''',(sid,))
	return render_template('seller/yourProducts.html', grouped_products=grouped_data,
		grouped_sellers=seller_data, offer_history = offer_history)

# View Product from Seller's Perspective
@bp.route("/viewProduct/<int:pid>")
def seller_view_product(pid:int):
	result = SQLReadWrite.execute_query('SELECT * from products where pid=%s', (pid,))
	ratings = SQLReadWrite.execute_query('SELECT * from ratings WHERE pid=%s', (pid))
	finalRating = 0
	if ratings:
		for rating in ratings:
			finalRating += float(rating["rating"])

		finalRating = format(float(finalRating/len(ratings)), '.2f')
	else: 
		finalRating = "No ratings!"

	return render_template('seller/productPage.html', product=result[0], ratings=finalRating)

@bp.route("/create-offer-price/<int:pid>", methods=['POST'])
def add_offered_price(pid:int):
    sid = g.user['id']
    offerPrice = float(request.form['offerPrice'])
    orgOfferPrice = request.form['offerPrice']

    query = '''UPDATE products SET offerImg = %(filename)s WHERE pid = %(pid)s'''
    
    # Transaction - 1. Uploads File,  2. Get File's name that is about to get deleted,
    # 3.Update Offer History, 4.Update Offer in products Table, 5. Delete redundant file 
    with SQLReadWrite.engine.connect() as conn:
    	transaction = conn.begin()
    	try:
            u_filename = upload_file(pid, 'OFFERS_UPLOAD_FOLDER')
            result = SQLReadWrite.execute_query("SELECT offerImg FROM products WHERE pid=%s", (pid,))
            if result:
                d_filename =result[0]['offerImg']
            conn.execute('''INSERT INTO offerHistory (`pid`, `sid`, `offerPrice`)
                VALUES( %s, %s, %s)''', (pid, sid, orgOfferPrice), put_op = True)
            conn.execute('''UPDATE products SET offerPrice = %s , offerImg = %s WHERE pid = %s''',
            	(offerPrice, u_filename, pid))
            delete_image(d_filename,'OFFERS_UPLOAD_FOLDER')
            transaction.commit()
    	except Exception as e:
            transaction.rollback()
            delete_image(u_filename,'OFFERS_UPLOAD_FOLDER')
            flash(str(e))
            # raise e

    if not get_flashed_messages():
    	flash("Offer Created!")
    return redirect(url_for('seller.seller_view_product', pid = pid))

# Add quantity to the product
@bp.route("/add-quantity/<int:pid>", methods=['POST'])
def add_quantity(pid:int):
	quantity = int(request.form['quantity'])
	SQLReadWrite.execute_query('UPDATE products SET quantity = quantity + %s WHERE pid = %s',
		(quantity, pid), True)
	if not get_flashed_messages():
		flash("Quantity Added!")
	return redirect(url_for('seller.seller_view_product', pid = pid))

def upload_file(pid,config_name):
    '''Func to upload file in given folder'''
    if 'file' not in request.files:
        raise Exception('No file part in the request')

    file = request.files['file']

    if file.filename == '':
        raise Exception('No selected file')

    if file:
        filename = secure_filename(file.filename)
        app = current_app._get_current_object()
        filename = get_unique_filename(app.config['OFFERS_UPLOAD_FOLDER'], filename)
        
        try:
            file.save(os.path.join(app.config[config_name], filename))

        except Exception as e:
        	raise e
        	
        return filename

    raise Exception('File Upload Failed')

def delete_image(filename, config_name):
    '''Func to delete given file from given path'''
    app = current_app._get_current_object()
    if filename is not None:
        image_path = os.path.join(app.config[config_name], filename)
        if os.path.exists(image_path):
            try:
                os.remove(image_path)
            except Exception as e:
                raise Exception(f"Error deleting image: {e}")

def get_unique_filename(folder, filename):
    '''Generates Unique filenames to avoid conflicts'''
    base, extension = os.path.splitext(filename)
    counter = 1
    unique_filename = filename

    while os.path.exists(os.path.join(folder, unique_filename)):
        unique_filename = f"{base}_{counter}{extension}"
        counter += 1

    return unique_filename

def get_best_seller_name():
    '''Get best seller'''
	# Execute a query to retrieve the seller names
    query = "SELECT sid, COUNT(*) AS orderCount FROM user_history GROUP BY sid;"
    results = SQLReadWrite.execute_query(query)
    orderCount = (results[0]["orderCount"])
    orderSellerId = results[0]["sid"]

    query = f"SELECT name FROM sellers WHERE id={orderSellerId}"
    results = SQLReadWrite.execute_query(query)
    sellerName = results
    return sellerName

# def get_offer_history():
# 	query = "SELECT * FROM offer_history ORDER BY id ASC LIMIT 20"
# 	results = SQLReadWrite.execute_query(query)
# 	return results
