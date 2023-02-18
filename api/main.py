import base64
import io
import logging
from flask import Flask, request, jsonify

from models import predict
app = Flask("plant")
from PIL import Image


@app.post('/')
def make_prediction():
    image = request.get_json()['image']
    image_data = base64.b64decode(image)
    image = Image.open(io.BytesIO(image_data))
    results = predict(image)
    return jsonify(output1=results[0], output2=results[1])


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8001)
