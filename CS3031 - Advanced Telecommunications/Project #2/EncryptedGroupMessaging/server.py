from datetime import datetime
from flask import Flask, jsonify, request
import hashlib
import logging

app = Flask(__name__)
log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

USERS, GROUPS = {}, {}


# login to the server
@app.route('/api/login', methods=['POST'])
def login():
    is_valid, message, code = validate_request(request, ('username', 'password', 'port'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, port = json['username'], json['password'], json['port']
    if username in USERS:
        return 'Username in use', 400
    else:
        USERS[username] = {'password': hash_password(password), 'port': port}
        log('USER', f"User '{username}' logged in")
        return 'Login successful', 200


# create a group
@app.route('/api/group/create', methods=['POST'])
def group_create():
    is_valid, message, code = validate_request(request, ('username', 'password', 'groupname'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, groupname = json['username'], json['password'], json['groupname']
    if username not in USERS:
        return 'User does not exist', 400
    elif not validate_password(username, password):
        return 'Invalid password', 401
    elif groupname in GROUPS:
        return 'Group name in use', 400
    else:
        GROUPS[groupname] = {'admin': username, 'users': {username}, 'messages': []}
        log('GROUP', f"Group '{groupname}' created by '{username}'")
        return 'Group created successfully', 200


# destroy a group
@app.route('/api/group/destroy', methods=['POST'])
def group_destroy():
    is_valid, message, code = validate_request(request, ('username', 'password', 'groupname'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, groupname = json['username'], json['password'], json['groupname']
    if username not in USERS:
        return 'User does not exist', 400
    elif not validate_password(username, password):
        return 'Invalid password', 401
    elif groupname not in GROUPS:
        return 'Group does not exist', 400
    elif username != GROUPS[groupname]['admin']:
        return 'User does not have permission to modify group', 401
    else:
        del GROUPS[groupname]
        log('GROUP', f"Group '{groupname}' destroyed by '{username}'")
        return 'Group destroyed successfully', 200


# add a user to a group
@app.route('/api/group/add', methods=['POST'])
def group_add():
    is_valid, message, code = validate_request(request, ('username', 'password', 'groupname', 'add_username'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, groupname, add_username = json['username'], json['password'], json['groupname'], json['add_username']
    if username not in USERS or add_username not in USERS:
        return 'User does not exist', 400
    elif not validate_password(username, password):
        return 'Invalid password', 401
    elif groupname not in GROUPS:
        return 'Group does not exist', 400
    elif username != GROUPS[groupname]['admin']:
        return 'User does not have permission to modify group', 401
    else:
        GROUPS[groupname]['users'].add(add_username)
        log('GROUP', f"User '{add_username}' added to group '{groupname}'")
        return 'User added successfully', 200


# remove a user from a group
@app.route('/api/group/remove', methods=['POST'])
def group_remove():
    is_valid, message, code = validate_request(request, ('username', 'password', 'groupname', 'rem_username'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, groupname, rem_username = json['username'], json['password'], json['groupname'], json['rem_username']
    if username not in USERS or rem_username not in USERS:
        return 'User does not exist', 400
    elif not validate_password(username, password):
        return 'Invalid password', 401
    elif groupname not in GROUPS:
        return 'Group does not exist', 400
    elif username != GROUPS[groupname]['admin']:
        return 'User does not have permission to modify group', 401
    elif username == rem_username:
        return 'Cannot remove admin from group', 401
    elif rem_username not in GROUPS[groupname]['users']:
        return 'User not in group', 400
    else:
        GROUPS[groupname]['users'].remove(rem_username)
        log('GROUP', f"User '{rem_username}' removed from group '{groupname}'")
        return 'User removed successfully', 200


# join a group you're a member of
@app.route('/api/group/join', methods=['POST'])
def group_join():
    is_valid, message, code = validate_request(request, ('username', 'password', 'groupname'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, groupname = json['username'], json['password'], json['groupname']
    if username not in USERS:
        return 'User does not exist', 400
    elif not validate_password(username, password):
        return 'Invalid password', 401
    elif groupname not in GROUPS:
        return 'Group does not exist', 400
    elif username not in GROUPS[groupname]['users']:
        return 'User not in group', 401
    else:
        response = {}
        for member in GROUPS[groupname]['users']:
            if member != username:
                response[member] = USERS[member]['port']
        log('GROUP', f"User '{username}' joined group '{groupname}'")
        return jsonify(response)


# send a message to a group
@app.route('/api/message/send', methods=['POST'])
def message_send():
    is_valid, message, code = validate_request(request, ('username', 'password', 'groupname', 'encrypted_messages'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, groupname, encrypted_messages = json['username'], json['password'], json['groupname'], json['encrypted_messages']
    if username not in USERS:
        return 'User does not exist', 400
    elif not validate_password(username, password):
        return 'Invalid password', 401
    elif groupname not in GROUPS:
        return 'Group does not exist', 400
    elif username not in GROUPS[groupname]['users']:
        return 'User not in group', 401
    else:
        GROUPS[groupname]['messages'].append({
            'sender': username,
            'timestamp': datetime.now(),
            'message': encrypted_messages
        })
        log('GROUP', f"User '{username}' sent a message to group '{groupname}'")
        for recipient in encrypted_messages:
            log('MESSAGE', f"Encrypted message to user '{recipient}': '{encrypted_messages[recipient]}'")
        return 'Message sent successfully', 200


# get the messages for a group
@app.route('/api/message/get', methods=['POST'])
def message_get():
    is_valid, message, code = validate_request(request, ('username', 'password', 'groupname'))
    if not is_valid:
        return message, code
    json = request.get_json()
    username, password, groupname = json['username'], json['password'], json['groupname']
    if username not in USERS:
        return 'User does not exist', 400
    elif not validate_password(username, password):
        return 'Invalid password', 401
    elif groupname not in GROUPS:
        return 'Group does not exist', 400
    elif username not in GROUPS[groupname]['users']:
        return 'User not in group', 401
    else:
        return jsonify(GROUPS[groupname]['messages'])


# check for valid password
def validate_password(username, password):
    return hash_password(password) == USERS[username]['password']


# get the hash of a password
def hash_password(password):
    return hashlib.sha256(password.encode('utf-8')).digest()


# ensure request is correctly formatted
def validate_request(req, params):
    if not req.is_json:
        return False, 'Invalid request: not JSON', 400
    json = req.get_json()
    for param in params:
        if param not in json:
            return False, 'Invalid request: missing parameters', 400
    return True, None, None


# log to console
def log(log_type, text):
    print(f'[{log_type}] {text}')


if __name__ == '__main__':
    import argparse
    argp = argparse.ArgumentParser()
    argp.add_argument('port', type=int, help='port to host the server on')
    args = argp.parse_args()
    app.run(port=args.port)
