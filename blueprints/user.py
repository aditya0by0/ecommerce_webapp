from flask import flash, get_flashed_messages
from flask import Blueprint
from flask import redirect
from flask import render_template
from flask import url_for
from flask import request
from flask import session
from flask import g

from sqlalchemy.sql import text
from datetime import datetime
import random

from daolayer.SQLReadWrite import SQLReadWrite
from blueprints import auth

bp = Blueprint("user", __name__, url_prefix="/user")

# Authenticate User for all the Routes/Api available in this blueprint
@bp.before_request
def load_logged_in_user():
	user_id = session.get("user_id")

	if user_id is None:
		g.user = None
		flash("Please, Login in with your user account")
		return redirect(url_for("auth.login"))
	else:
		result = SQLReadWrite.execute_query("SELECT * FROM users WHERE id = %s", (user_id,))
		if result:
			g.user = result[0]
			g.user['role'] = 'User'
		else:
			flash("Please, Login in with your user account")
			return redirect(url_for("auth.login"))	

# Route to User's Purchase History Page
@bp.route('/history')
def show_user_history():
	uid = g.user['id']
	result = SQLReadWrite.execute_query('''SELECT u.*,p.*,s.name, s.email 
		FROM user_history u 
		JOIN products p ON u.pid = p.pid 
		JOIN products_sellers ps ON ps.pid=p.pid
		JOIN sellers s ON s.id = ps.sid 
		WHERE u.id =%s''', (uid,))
	return render_template("/user/userHistory.html", products=result)

# Delete a Product from the user cart
@bp.route('/delete-cart-item/<int:pid>')
def del_cart_item(pid:int):
	uid = g.user['id']
	SQLReadWrite.execute_query('''DELETE FROM cart WHERE id=%s 
		AND pid=%s''', (uid, pid), True)
	return redirect(url_for("user.show_cart"))

# Show user cart along the with products added to the cart
@bp.route("/show-cart")
def show_cart():
	uid = g.user['id']
	total = 0
	result = SQLReadWrite.execute_query('''SELECT * FROM products p 
		INNER JOIN cart c ON p.pid = c.pid 
		WHERE c.id=%s''', (uid,))
	if result:
		total = cal_total_cart(result)
	return render_template("cart.html", products=result, total=total)

# Buy all the items/products in the User's cart
@bp.route("/buy-cart")
def buy_user_cart():
	uid = g.user['id']
	curr_tmsp = datetime.now()
	
	result = SQLReadWrite.execute_query('''SELECT c.*,p.*,s.name, s.email 
		FROM cart c 
		INNER JOIN products p ON c.pid = p.pid
		INNER JOIN products_sellers ps ON ps.pid = p.pid
		INNER JOIN sellers s ON s.id = ps.sid 
		WHERE c.id = %s''', (uid,))
	
	query_p = '''UPDATE products SET quantity = quantity - :p_quantity 
		WHERE pid = :pid '''
	query_s = '''INSERT INTO user_history (id, pid, date_, p_quantity) VALUES (%s, %s, %s, %s)
		ON DUPLICATE KEY UPDATE p_quantity = p_quantity + %s'''
	
	with SQLReadWrite.engine.connect() as conn:
		transaction = conn.begin()
		try:
			# Atomic operation to update quantity and user history
			conn.execute(text(query_p), result)
			# conn.execute(text(query_s), result) -- not working
			for p in result : 
				conn.execute(query_s, (uid, p['pid'], curr_tmsp, p['p_quantity'],
				 p['p_quantity'] ))
			conn.execute("DELETE FROM cart WHERE id = %s", (uid,))
			transaction.commit()
		
		except Exception as e:
			transaction.rollback()
			flash(str(e))
			return redirect(url_for("user.show_cart"))
	
	p_quantities = [row['p_quantity'] for row in result]
	total =  cal_total(result, p_quantities)

	# Recommend a product based on a random product from list of all the purchased products 
	product_ids = [row['pid'] for row in result]
	random_product_id = random.choice(product_ids)
	recommended_product = recommend_product(random_product_id, product_ids)

	return render_template("bootstrap/productBought.html", purchases=result, 
		p_quantities = p_quantities, total = total, zip=zip, rec_prod = recommended_product)

# Submit the rating for the given product
@bp.route("/submit-rating/<int:p_id>", methods=["POST"])
def submit_rating(p_id:int):
	uid = g.user['id']
	if 'rating' not in request.form:
		flash('No Rating Selected')
		return redirect(url_for('user.show_user_history'))
	rating = request.form["rating"]
	SQLReadWrite.execute_query('''INSERT INTO ratings (id, rating, pid) VALUES(%s, %s,%s)
		ON DUPLICATE KEY UPDATE rating = %s''', (uid,rating, p_id, rating), True)
	flash("Thank you for rating the product!")
	return redirect("/")

# For buying a product OR adding it to cart
@bp.route("/buy-add-product/<int:p_id>" , methods=['POST'])
def buy_product(p_id:int):
	action = request.form.get("action")
	p_quantity = int(request.form["quantity"])
	u_id = g.user['id']
	
	# Buying a product
	if action == "buyNow":
		with SQLReadWrite.engine.connect() as conn:
			transaction = conn.begin()
			try:
				# A database atomic operation to Update quantity and add user history
				conn.execute('''UPDATE products SET quantity = quantity - %s 
				where pid = %s''',(p_quantity, p_id))
				conn.execute ('''INSERT INTO user_history (id, pid, p_quantity)
				VALUES (%s, %s, %s)''', (u_id, p_id, p_quantity))
				transaction.commit()
			except Exception as e:
				transaction.rollback()
				flash(str(e))
				return redirect(url_for("get_product_page", p_id=p_id))

		# Get the data for the product which user is about to purchase 
		# needed for - Purchase Sucessful page
		purchases = SQLReadWrite.execute_query('''SELECT p.*, s.name, s.email 
			FROM products p 
			INNER JOIN products_sellers ps ON ps.pid = p.pid
			INNER JOIN sellers s ON s.id = ps.sid
			WHERE p.pid = %s''',
			(p_id,))
		
		# Calculation of the Total amount
		total = cal_total(purchases, [p_quantity])

		recommended_product = recommend_product(p_id, [p_id])

		return render_template("bootstrap/productBought.html", purchases=purchases, 
			p_quantities = [p_quantity], total = total, zip=zip, rec_prod = recommended_product) 
	
	# Add the product to user cart
	elif action == "a2c":
		# Add to cart, if same product is added again update the quantity
		SQLReadWrite.execute_query('''INSERT INTO cart (id, pid, p_quantity) 
			VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE p_quantity = p_quantity + %s''', 
			(u_id, p_id, p_quantity, p_quantity), True)
		
		flash("Product Sucessfully added to the cart")
		return redirect(url_for("get_product_page", p_id=p_id))
	
	else : 
		return "Invalid Action"

def recommend_product(pid, pids_list):
	# Recommend a single product 

	id_placeholders = ','.join(['%s'] * len(pids_list))
	
	# Get another random product from same category
	category = SQLReadWrite.execute_query('''SELECT category FROM products 
		WHERE pid = %s LIMIT 1''', (pid,))[0]['category']

	result = SQLReadWrite.execute_query(f'''SELECT * FROM products 
		WHERE pid NOT IN ({id_placeholders}) 
		AND category = %s ORDER BY RAND() LIMIT 1''', pids_list + [category])

	# If no another product exists from the same category, 
	# get another random product from the seller of same product 
	if result is None:
		seller_id = SQLReadWrite.execute_query('''SELECT sid FROM products_sellers
			WHERE pid = %s''', (pid,))[0]['sid']

		result = SQLReadWrite.execute_query(f'''SELECT p.* FROM products p 
			JOIN products_sellers ps ON ps.pid = p.pid
		 	WHERE p.pid NOT IN ({id_placeholders}) AND sid = %s ORDER BY RAND() LIMIT 1''', 
		 	pids_list + [seller_id])

	return result

def cal_total_cart(cart_products):
	# Func - to calculate 'Total amount' for the products added to cart
	total=0
	for product in cart_products:
		if product['offerPrice'] > 0.0 :
			total += product['offerPrice'] * product['p_quantity']
		else:
			total += product['price'] * product['p_quantity']
	return total

def cal_total(purchases, p_quantities):
	'''func to calculate the total amount based on offer price avaible or not, and
	the purchased the quantity'''
	if len(purchases) == len(p_quantities):
		total = 0
		for purchase, quantity in zip(purchases, p_quantities):

			if purchase['offerPrice'] > 0.0 :
				total += purchase['offerPrice'] * quantity
			else:
				total += purchase['price'] * quantity
		return total
	return None