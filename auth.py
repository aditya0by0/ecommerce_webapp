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
        g.user = (result)
        # g.user = (
        #     get_db().execute("SELECT * FROM user WHERE id = ?", (user_id,)).fetchone()
        # )

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
        # db = get_db()
       
        try:
            # db.execute(
            #     "INSERT INTO user (username, password) VALUES (?, ?)",
            #     (username, generate_password_hash(password)),
            # )
            SQLReadWrite.execute_query(
                "INSERT INTO users (name,username, password, email) VALUES (%s, %s, %s, %s)",
                (name,username, generate_password_hash(password),email))

            # with SQLReadWrite.engine.connect() as conn:
            #     conn.execute(
            #         "INSERT INTO user (username, password) VALUES (?, ?)",
            #         (username, generate_password_hash(password)),
            # )
            # db.commit()
        # except db.IntegrityError:
        except IntegrityError:
            
            # The username was already taken, which caused the
            # commit to fail. Show a validation error.
            error = f"User {username} or Email: {email} is already registered."
        else:
            # Success, go to the login page.
            return redirect(url_for("auth.login"))

        flash(error)

    return render_template("auth/signupPage.html")

@bp.route("/login", methods=("GET", "POST"))
def login():
    """Log in a registered user by adding the user id to the session."""
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        # db = get_db()
        error = None
        
        # user = db.execute(
        #     "SELECT * FROM user WHERE username = ?", (username,)
        # ).fetchone()
        user = SQLReadWrite.execute_query("SELECT * FROM users WHERE username = %s",
            (username,))
        print(username)
        print('User----------------',user)
        if user is None:
            error = "Incorrect username."
        elif not check_password_hash(user[0]["password"], password):
            error = "Incorrect password."

        if error is None:
            # store the user id in a new session and return to the index
            session.clear()
            session["user_id"] = user[0]["id"]
            return redirect(url_for("get_home_page"))

        flash(error)

    return render_template("auth/loginPage.html")


@bp.route("/logout")
def logout():
    """Clear the current session, including the stored user id."""
    session.clear()
    return redirect(url_for("home"))