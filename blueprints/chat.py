from flask import flash, get_flashed_messages
from flask import Blueprint
from flask import redirect
from flask import render_template
from flask import url_for
from flask import request
from flask import session
from flask import g

from daolayer.SQLReadWrite import SQLReadWrite
from blueprints import seller, user, auth

bp = Blueprint("chat", __name__, url_prefix="/chat")

@bp.route("/u_w_s/<int:pid>", methods=["POST", "GET"])
def chat_with_seller(pid:int):
    user.load_logged_in_user()
    uid = g.user['id']
    seller_data = SQLReadWrite.execute_query('''SELECT ps.sid, p.pName
    	FROM products_sellers ps
        INNER JOIN products p ON p.pid = ps.pid
        WHERE ps.pid = %s''', (pid,))
    sid = seller_data[0]['sid']
    product_name = seller_data[0]['pName']
    
    if request.method == 'GET':
        sorted_msgs = get_msgs(uid, sid, pid)

        return render_template("chat/chatPage.html", msgs = sorted_msgs,
        	p_name=product_name, pid=pid)

    message = request.form['inputTxt']
    SQLReadWrite.execute_query('''INSERT INTO chats (sender_id, recipient_id,
        product_id,message,is_user_d_sender) VALUES (%s,%s,%s,%s,%s)''',
        (uid,sid,pid,message,1), True)
    return redirect(url_for("chat.chat_with_seller",pid=pid))

@bp.route("/sellerChatPage", methods=["POST", "GET"])
def get_seller_chat_page():
    seller.load_logged_in_seller()
    sid = g.user['id'] 
    
    if request.method == 'POST':
        uid = request.form['uid']
        pid = request.form['pid']
        uname = request.form['username'] 
        return redirect(url_for('chat.get_seller_chat_page',uid=uid, pid=pid, uname=uname))

    uid = request.args.get('uid', None)
    pid = request.args.get('pid', None)
    uname = request.args.get('uname', None)

    if uid is not None and pid is not None:
        sorted_msgs = get_msgs(uid,sid,pid)
        product_data = SQLReadWrite.execute_query('''SELECT pName
            FROM products WHERE pid = %s''', (pid,))
        pname = product_data[0]['pName']
        sorted_msgs = get_msgs(uid, sid, pid)
    else : 
        sorted_msgs = None
        pname=None

    people_list = get_people_list(sid)
    return render_template("chat/chatPage.html", msgs = sorted_msgs, pid=pid,
        is_seller = 1, people_list=people_list, username=uname, uid=uid, pname=pname)

@bp.route("/s_w_u", methods=["POST"])
def chat_with_user():
    seller.load_logged_in_seller()
    sid = g.user['id']
    uid = int(request.form['uid'])
    pid = int(request.form['pid'])
    uname = request.form['uname']
    message = request.form['inputTxt']
    SQLReadWrite.execute_query('''INSERT INTO chats (sender_id, recipient_id,
        product_id,message,is_user_d_sender) VALUES (%s,%s,%s,%s,%s)''',
        (sid,uid,pid,message,0), True)
    return redirect(url_for('chat.get_seller_chat_page',uid=uid, pid=pid, uname=uname))

def get_people_list(sid):
    people_list = SQLReadWrite.execute_query('''SELECT p.pName, u.username, p.pid, u.id
        FROM chats c
        INNER JOIN products p ON p.pid = c.product_id
        INNER JOIN users u ON u.id = c.sender_id 
        WHERE recipient_id=%s 
        GROUP BY c.product_id, c.sender_id, p.pName, u.username''',(sid,))
    return people_list

def get_msgs(uid,sid,pid):
    user_msgs = SQLReadWrite.execute_query('''SELECT * FROM chats WHERE
            sender_id=%s AND recipient_id=%s AND product_id=%s AND is_user_d_sender=1''',
            (uid,sid,pid))
    seller_msgs = SQLReadWrite.execute_query('''SELECT * FROM chats WHERE
        sender_id=%s AND recipient_id=%s AND product_id=%s AND is_user_d_sender=0''',
        (sid,uid,pid))

    if user_msgs is None and seller_msgs is None:
        msgs = None
        sorted_msgs = None
    elif seller_msgs is None : 
        msgs = user_msgs
    elif user_msgs is None:
        msgs = seller_msgs
    else :
        msgs = user_msgs + seller_msgs

    if msgs is not None:
        sorted_msgs = sorted(msgs, key=lambda x: x['timestamp'])
    else:
        sorted_msgs=None

    return sorted_msgs
    
