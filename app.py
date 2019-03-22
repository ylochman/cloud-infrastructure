from flask import Flask, redirect, url_for, request, render_template
from redis import Redis, RedisError
import os
import socket
from nn import *
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
from matplotlib.figure import Figure

import matplotlib.pyplot as plt
import io
import base64
 
def build_graph(xs, ys):
    img = io.BytesIO()
    for x, y in zip(xs, ys):
        plt.plot(x, y)
    plt.grid(1)
    plt.xlabel('Iterations')
    plt.ylabel('Cost function')
    plt.legend(['Train', 'Validation'])
    plt.savefig(img, format='png')
    img.seek(0)
    graph_url = base64.b64encode(img.getvalue()).decode()
    plt.close()
    return 'data:image/png;base64,{}'.format(graph_url)

app = Flask(__name__)
redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

@app.route('/')
def root() :
    return render_template('submit.html')

@app.route('/nn', methods = ['POST', 'GET'])
def nn_init():
    if request.method == 'POST':
        sampleSize = request.form['sampleSize']
        inputFeatures = request.form['inputFeatures']
        return redirect(url_for('result', sampleSize=sampleSize,
                                      inputFeatures=inputFeatures))
    else:
        sampleSize = request.args.get('sampleSize')
        inputFeatures = request.args.get('inputFeatures')
        return redirect(url_for('result', sampleSize=sampleSize,
                                      inputFeatures=inputFeatures))


@app.route('/result/<sampleSize>/<inputFeatures>')
def result(sampleSize, inputFeatures):
    # try:
    #     visits = redis.incr("counter")
    # except RedisError:
    #     visits = "<i>cannot connect to Redis, counter disabled</i>"

    # html = "<b>Hostname:</b> {hostname}<br/>".format(hostname=socket.gethostname()) + \
    #        "<b>Visits:</b> {visits}<br/><br/>".format(visits=visits)

    sampleSize = int(sampleSize)
    inputFeatures = int(inputFeatures)

    train_data, train_labels, \
    val_data, val_labels, \
    test_data, test_labels = create_data(sampleSize, inputFeatures)

    NN, ys = model_data(train_data, train_labels, val_data, val_labels)
    loss, mape = test_model(NN, test_data, test_labels)
    print(len(ys[0]))
    xs = [range(len(y)) for y in ys]
    graph_url = build_graph(xs, ys)

    return render_template('result.html',
                            sampleSize=sampleSize, inputFeatures=inputFeatures,
                            loss=loss, mape=mape,
                            graph=graph_url)


if __name__ == '__main__':
   app.run(debug = True)