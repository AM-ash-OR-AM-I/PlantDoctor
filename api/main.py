import base64
import io
import json
import logging
from flask import Flask, request, jsonify

from models import predict
app = Flask("plant")
from PIL import Image


with open("data.json", "r") as f:
    data_json = json.load(f)

@app.post('/')
def make_prediction():
    image = request.get_json()['image']
    image_data = base64.b64decode(image)
    image = Image.open(io.BytesIO(image_data))
    results = predict(image)
    data = data_json.get(results)
    if data is None:
        return jsonify(disease=results)
    else:
        return jsonify(
            disease=results,
            causes=data.get("Causes"),
            prevention=data.get("Prevention"),
            remedies=data.get("Remedies"),
            fertilizer=data.get("Fertilizer"),

        )


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8001, debug=True)
