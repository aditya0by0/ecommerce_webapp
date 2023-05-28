import functools

from flask import Blueprint
from flask import flash
from flask import g
from flask import redirect
from flask import render_template
from flask import request
from flask import session
from flask import url_for

from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash

from sqlalchemy.exc import IntegrityError

from daolayer.SQLReadWrite import SQLReadWrite

bp = Blueprint("auth", __name__, url_prefix="/auth")

def login_required(view):
    """View decorator that redirects anonymous users to the login page."""

    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for("auth.login"))

        return view(**kwargs)

    return wrapped_view

@bp.before_app_request
def load_logged_in_user():
    """If a user id is stored in the session, load the user object from
    the database into ``g.user``."""
    user_id = session.get("user_id")

    if user_id is None:
        g.user = None
    else:
        with SQLReadWrite.engine.connect() as conn:
            result = conn.execute("SELECT * FROM users WHERE id = %s", (user_id,)).fetchone()
        g.user = result

@bp.route("/signup", methods=("GET", "POST"))
def register():
    """Register a new user.
    Validates that the username is not already taken. Hashes the
    password for security.
    """
    if request.method == "POST":
        name = request.form['name']
        email = request.form['email']
        username = request.form["username"]
        password = request.form["password"]
       
        try:

            if 'chkbx-seller' not in request.form:
                SQLReadWrite.execute_query(
                    "INSERT INTO users (name,username, password, email) VALUES (%s, %s, %s, %s)",
                    (name,username, generate_password_hash(password),email), True)
            else : 
                b_address = request.form['b-address']
                SQLReadWrite.execute_query(
                    "INSERT INTO sellers (name, username, password, email, address) VALUES (%s, %s, %s, %s, %s)",
                    (name,username, generate_password_hash(password),email, b_address), True)
        except IntegrityError as e:
            # The username/email was already taken, which caused the
            # commit to fail. Show a validation error.
            error = f"User {username} or Email: {email} is already registered."
        else:
            # Success, go to the login page.
            flash('Account created successfully. Please Login.', 'success')
            return redirect(url_for("auth.login"))

        flash(error)

    return render_template("auth/signupPage.html")

@bp.route("/login", methods=("GET", "POST"))
def login():
    """Log in a registered user by adding the user id to the session."""
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        error = None
        
        if 'chkbx-seller' not in request.form:
            user = SQLReadWrite.execute_query("SELECT * FROM users WHERE username = %s",
            (username,))
        else:
            user = SQLReadWrite.execute_query("SELECT * FROM sellers WHERE username = %s",
            (username,))
        
        if user is None:
            error = "Incorrect username."
        elif not check_password_hash(user[0]["password"], password):
            error = "Incorrect password."

        if error is None:
            # store the user id in a new session and return to the index
            session.clear()
            session["user_id"] = user[0]["id"]

            if 'chkbx-seller'in request.form:
                return redirect(url_for('seller.show_seller_page', sid=session["user_id"]))

            return redirect(url_for("get_home_page"))

        flash(error)

    return render_template("auth/loginPage.html")


@bp.route("/logout")
def logout():
    """Clear the current session, including the stored user id."""
    session.clear()
    return redirect(url_for("get_home_page"))