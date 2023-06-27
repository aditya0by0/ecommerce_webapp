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

from daolayer.SQLReadWrite import SQLReadWrite
from blueprints import auth

bp = Blueprint("user", __name__, url_prefix="/user")

@bp.before_request
def load_logged_in_user():
	user_id = session.get("user_id")

	if user_id is None:
		g.user = None
		flash("Please, Login in with your user account")
		
	else:
		result = SQLReadWrite.execute_query("SELECT * FROM users WHERE id = %s", (user_id,))
		if result:
			g.user = result[0]
			g.user['role'] = 'User'
		else:
			flash("Please, Login in with your user account")
			return redirect(url_for("auth.login"))	

@bp.route('/history')
def show_user_history():
	uid = g.user['id']
	result = SQLReadWrite.execute_query('''SELECT u.*,p.*,s.name, s.email 
		FROM user_history u 
		JOIN products p ON u.pid = p.pid 
		JOIN products_sellers ps ON ps.pid=p.pid
		JOIN sellers s ON s.id = ps.sid 
		WHERE u.id =%s''', (uid,))
	print(result[0])
	return render_template("userHistory.html", products=result)

@bp.route('/delete-cart-item/<int:pid>')
def del_cart_item(pid:int):
	uid = g.user['id']
	SQLReadWrite.execute_query('''DELETE FROM cart WHERE id=%s 
		AND pid=%s''', (uid, pid), True)
	print(uid, pid)
	return redirect(url_for("user.show_cart"))

@bp.route("/show-cart")
def show_cart():
	uid = g.user['id']
	total = 0
	result = SQLReadWrite.execute_query('''
		SELECT * FROM products p INNER JOIN cart c 
		ON p.pid = c.pid WHERE c.id=%s''', (uid,))
	if result:
		total = cal_total_cart(result)
	return render_template("cart.html", products=result, total=total)

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

	return render_template("bootstrap/productBought.html", purchases=result , 
			p_quantities = p_quantities, total = total, zip=zip)

@bp.route("/submit-rating/<int:p_id>", methods=["POST"])
def submit_rating(p_id:int):
	rating = request.form["rating"]
	SQLReadWrite.execute_query(f"INSERT INTO ratings (`rating`, `pid`) VALUES({rating}, {p_id})")
	flash("Thank you for rating the product!")
	return redirect("/")

# Route - for any buying or add to card user action
@bp.route("/buy-add-product/<int:p_id>" , methods=['POST'])
def buy_product(p_id:int):
	action = request.form.get("action")
	p_quantity = int(request.form["quantity"])
	u_id = g.user['id']
	# Buy Now - action Logic
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

		# Get the data for the purchased product for - Purchase Sucessful page
		purchases = SQLReadWrite.execute_query('''SELECT p.*, s.name, s.email 
			FROM products p 
			INNER JOIN products_sellers ps ON ps.pid = p.pid
			INNER JOIN sellers s ON s.id = ps.sid
			WHERE p.pid = %s''',
			(p_id,))
		total = cal_total(purchases, [p_quantity])

		return render_template("bootstrap/productBought.html", purchases=purchases , 
			p_quantities = [p_quantity], total = total, zip=zip) 
	
	# Add to Cart - action logic  
	elif action == "a2c":
		SQLReadWrite.execute_query('''INSERT INTO cart (id, pid, p_quantity) 
			VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE p_quantity = p_quantity + %s''', 
			(u_id, p_id, p_quantity, p_quantity), True)
		# if not get_flashed_messages():
		flash("Product Sucessfully added to the cart")
		
		return redirect(url_for("get_product_page", p_id=p_id))
	
	else : 
		return "Invalid Action"

def cal_total_cart(cart_products):
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