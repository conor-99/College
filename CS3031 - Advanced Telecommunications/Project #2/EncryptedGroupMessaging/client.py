import base64
import requests
import socket
import threading
import time
import tkinter
from Crypto import Random
from Crypto.Cipher import PKCS1_OAEP
from Crypto.PublicKey import RSA
from enum import Enum
from queue import Queue
from tkinter import *


# command enum
class Command(Enum):
    CREATE = 1
    ADD = 2
    REMOVE = 3
    JOIN = 4
    SEND = 5
    DESTROY = 6


# config
USERNAME = ''  # username to use
PASSWORD = ''  # password to use for auth
CLIENT_PORT = -1  # port to listen for key exchanges on
SERVER_URL = 'http://127.0.0.1'  # api url
SERVER_PORT = -1  # api port
MOD_LEN = 1024  # modulus length for rsa

# global variables
currently_in_group = False  # is the user currently in a group
group_name = ''  # the name of the group the user in in
keys = {}  # local key storage
our_messages = Queue()  # messages to be printed when there's a chance


# start the client
def start_client():
    login_result = login()
    if not login_result:
        quit()
    while True:
        command, param = get_command()
        if command == Command.CREATE:
            create_group(param)
        elif command == Command.JOIN:
            join_group(param)
        elif command == Command.ADD:
            add_user(param)
        elif command == Command.REMOVE:
            remove_user(param)
        elif command == Command.SEND:
            send_message(param)


# start a new thread to exchange keys with other group members
def start_key_exchange(users):
    for user in users:
        # generate keys
        private_key = RSA.generate(MOD_LEN, Random.new().read)
        public_key = private_key.publickey()
        keys[user] = {}
        # send our username and public key to the other user
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect(('127.0.0.1', users[user]))
        sock.send(f'{USERNAME}|{public_key.exportKey().decode()}'.encode())
        # receive the other users public key
        encrypt_key = sock.recv(8192).decode()
        keys[user]['encrypt'] = encrypt_key
        keys[user]['decrypt'] = private_key


# start a new thread to listen for future key exchanges
def start_key_listener():
    # start listening on the client port
    sock = socket.socket()
    sock.bind(('', CLIENT_PORT))
    sock.listen(5)
    while True:
        conn, address = sock.accept()
        # extract the public key and username from the received data
        username, encrypt_key = conn.recv(8192).decode().split('|')
        keys[username] = {'encrypt': encrypt_key}
        # generate keys
        private_key = RSA.generate(MOD_LEN, Random.new().read)
        public_key = private_key.publickey()
        keys[username]['decrypt'] = private_key
        # send the public key
        conn.send(public_key.exportKey())
        conn.close()


# create a Tkinter display to show group messages
def start_group_terminal():
    ui = tkinter.Tk()
    ui.geometry("600x400")
    message_box = Listbox(ui, font=('Consolas', 10))
    message_box.pack(fill=BOTH, padx=10, pady=5)
    num_cur_messages = 0
    while True:
        ui.update_idletasks()
        ui.update()
        # add our messages to the ui
        while not our_messages.empty():
            message_box.insert(END, f"[{USERNAME}] {our_messages.get()}")
        # add new messages to the ui (if any exist)
        new_messages = get_messages()
        num_new_messages = len(new_messages)
        if num_new_messages > num_cur_messages:
            new_messages = new_messages[num_cur_messages:]
            num_cur_messages = num_new_messages
            for new_message in new_messages:
                message_box.insert(END, f"[{new_message['sender']}] {new_message['message']}")
        time.sleep(1)


# encrypt a message
def encrypt_message(text):
    messages = {}
    for user in keys:
        key = keys[user]['encrypt']
        # encrypt and encode the message
        encryptor = PKCS1_OAEP.new(RSA.importKey(key))
        messages[user] = base64.b64encode(encryptor.encrypt(text.encode())).decode()
    return messages


# decrypt received messages
def decrypt_messages(messages):
    decrypted_messages = []
    for message in messages:
        if USERNAME in message['message']:
            key = keys[message['sender']]['decrypt']
            encrypted_message = message['message'][USERNAME]
            # decrypt and decode the message and format it in a dictionary
            decryptor = PKCS1_OAEP.new(key)
            decrypted_text = decryptor.decrypt(base64.b64decode(encrypted_message.encode())).decode()
            decrypted_message = {'sender': message['sender'], 'message': decrypted_text}
            decrypted_messages.append(decrypted_message)
    return decrypted_messages


# login to the server
def login():
    status_code, message = make_request('login', {
        'username': USERNAME,
        'password': PASSWORD,
        'port': CLIENT_PORT
    })
    success = (status_code == 200)
    if not success:
        print(f'[ERROR] {message}')
    return success


# get a command from the user
def get_command():
    while True:
        text = input('>>> ').strip()
        if text == 'help':
            print_help()
        elif not currently_in_group:
            if text.startswith('create '):
                return Command.CREATE, text[7:]
            elif text.startswith('join '):
                return Command.JOIN, text[5:]
            else:
                print('[ERROR] Unrecognised command - type \'help\' for a list of commands')
        else:
            if text.startswith('add '):
                return Command.ADD, text[4:]
            elif text.startswith('remove '):
                return Command.REMOVE, text[7:]
            elif text.startswith('send '):
                return Command.SEND, text[5:]
            else:
                print('[ERROR] Unrecognised command - type \'help\' for a list of commands')


# print command help
def print_help():
    print('>>> Commands:')
    print('>>>   help')
    if not currently_in_group:
        print('>>>   create {GROUP}')
        print('>>>   join {GROUP}')
    else:
        print('>>>   add {USER}')
        print('>>>   remove {USER}')
        print('>>>   send {MESSAGE}')


# create a group
def create_group(_group_name):
    global currently_in_group, group_name
    status_code, message = make_request('group/create', {
        'username': USERNAME,
        'password': PASSWORD,
        'groupname': _group_name
    })
    if status_code != 200:
        print(f'[ERROR] {message}')
        return
    currently_in_group = True
    group_name = _group_name
    # start key listener and ui threads
    threading.Thread(target=start_key_listener, daemon=True).start()
    threading.Thread(target=start_group_terminal, daemon=True).start()


# join a group
def join_group(_group_name):
    global currently_in_group, group_name
    status_code, message, json = make_request('group/join', {
        'username': USERNAME,
        'password': PASSWORD,
        'groupname': _group_name
    }, json_response=True)
    if status_code != 200:
        print(f'[ERROR] {message}')
        return
    currently_in_group = True
    group_name = _group_name
    # start key exchange, key listener and ui threads
    threading.Thread(target=start_key_exchange, args=(json,), daemon=True).start()
    threading.Thread(target=start_key_listener, daemon=True).start()
    threading.Thread(target=start_group_terminal, daemon=True).start()


# add a user to a group
def add_user(add_username):
    status_code, message = make_request('group/add', {
        'username': USERNAME,
        'password': PASSWORD,
        'groupname': group_name,
        'add_username': add_username
    })
    if status_code != 200:
        print(f'[ERROR] {message}')


# remove a user from a group
def remove_user(rem_username):
    status_code, message = make_request('group/remove', {
        'username': USERNAME,
        'password': PASSWORD,
        'groupname': group_name,
        'rem_username': rem_username
    })
    if status_code != 200:
        print(f'[ERROR] {message}')


# send a message to a group
def send_message(message):
    our_messages.put(message)
    status_code, status_message = make_request('message/send', {
        'username': USERNAME,
        'password': PASSWORD,
        'groupname': group_name,
        'encrypted_messages': encrypt_message(message)
    })
    if status_code != 200:
        print(f'[ERROR] {status_message}')


# get a groups messages
def get_messages():
    status_code, status_message, json = make_request('message/get', {
        'username': USERNAME,
        'password': PASSWORD,
        'groupname': group_name
    }, json_response=True)
    if status_code != 200:
        print(f'[ERROR] {status_message}')
        return []
    return decrypt_messages(json)  # return the decrypted messages


# make an api request
def make_request(route, params, json_response=False):
    try:
        req = requests.post(f'{SERVER_URL}:{SERVER_PORT}/api/{route}', json=params)
        if not json_response:
            return req.status_code, req.text
        else:
            return req.status_code, req.text, ({} if req.status_code != 200 else req.json())
    except:
        return 500, 'Could not connect to server'


if __name__ == '__main__':
    import argparse
    argp = argparse.ArgumentParser()
    argp.add_argument('username', help='unique username to use')
    argp.add_argument('password', help='password to use')
    argp.add_argument('client_port', type=int, help='port to listen on')
    argp.add_argument('server_port', type=int, help='port the server is on')
    args = argp.parse_args()
    USERNAME = args.username
    PASSWORD = args.password
    CLIENT_PORT = args.client_port
    SERVER_PORT = args.server_port
    start_client()
