from flask import Flask, render_template, request
from flask import jsonify
import platform
app = Flask(__name__)

@app.route('/getip', methods=['GET','POST'])
def getip():

    if request.method == 'GET':

        return jsonify({
                    'Accept': request.accept_mimetypes,
                    'User-Agent': request.headers.get('User-Agent'),
                    'Host': request.host,
                    'Client IP': request.remote_addr
                    }), 200

    elif request.method == 'POST':

        data = request.get_json()
        client_ip = data['client_ip']
        host = data['host']
        user_agent = data['user_agent']
        accept = data['accept']

        return '''
                   Value client ip: {}
                   Value host: {}
                   Valuse user agent: {}
                   Valuse accept: {}'''.format(client_ip, host, user_agent, accept)

@app.route('/hello')
def hello():
    return 'Hello world! Nguyen Ngoc Tai'

@app.route('/connect_server_100')
def connect_server_100():
    return 'Hello world! connecting to server 192.168.100.100'

@app.route('/stop_server_100')
def stop_server_100():
    return 'Hello world! stoped server 192.168.100.100'

@app.route('/infor')
def infor():
    return platform.system()+ ' ' + platform.machine() +' '+ platform.platform()+ ' ' + platform.version()
    
@app.route('/run_script_100')
def run_script_100():
    return 'Hello world! running script on server 192.168.100.100'

@app.route('/fruits')
def fruits():
    beers = [
        {
            'brand': 'Guinness',
            'type': 'stout'
        },
        {
            'brand': 'Hop House 13',
            'type': 'lager'
        }
    ]
    list_of_fruits = ['banana', 'orange', 'apple']
    list_of_drinks = ['coke', 'milk', beers]
    return jsonify(Fruits=list_of_fruits, Drinks=list_of_drinks)

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True, port=5000)