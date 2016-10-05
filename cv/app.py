import flask
from flask import jsonify
import cv2
import glob
import os
import logging


app = flask.Flask(__name__)
logging.basicConfig(level=logging.DEBUG)

@app.route('/')
def index():
    return "Hello, World!"

@app.route('/image/<filename>')
def image(filename):
    logging.debug("Input filename:" + filename)
    aaa = check_jidori(filename)
    return jsonify(aaa)

def check_jidori(filename):
    # 返す変数
    face_detect_or_not = False
    detected_product_path = ""

    products_path = "/static/products/"
    jidoris_path = "/static/jidoris/"

    logging.debug('Read a image in :' + filename)

    image = cv2.imread(jidoris_path + filename)
    image_gray = cv2.cvtColor(image, 0) #グレースケール変換

    cascade = cv2.CascadeClassifier("haarcascade_frontalface_alt.xml")
    facerect = cascade.detectMultiScale(image_gray, scaleFactor=1.1, minNeighbors=1, minSize=(60, 60))

    if len(facerect) > 0:
        face_detect_or_not = True

    # ****************************************************************************
    # 商品画像の検知
    img2 = image
    gray2 = cv2.cvtColor(img2, 0)

    # 特徴量記述
    detector = cv2.AKAZE_create()

    kp2, des2 = detector.detectAndCompute(gray2, None)

    # 比較器作成
    bf = cv2.BFMatcher(cv2.NORM_HAMMING)

    for path in glob.glob(products_path+"*"):
        img1 = cv2.imread(path)
        gray = cv2.cvtColor(img1, 0)
        kp1, des1 = detector.detectAndCompute(gray, None)

        # 画像への特徴点の書き込み
        matches = bf.match(des1, des2)
        matches = sorted(matches, key = lambda x:x.distance)

        # store all the good matches as per Lowe's ratio test.
        good = []
        for m in matches:
            if m.distance < 70:
                good.append(m)

        if len(good)>10:
            logging.debug("マッチしました。%s" % path)
            detected_product_path = path
            #draw_params = dict(matchColor = (0,255,0), singlePointColor = None, matchesMask = matchesMask, flags = 2)

            break
        else:
            logging.debug("マッチしませんでした！")
            #matchesMask = None
            pass
    return {"face": face_detect_or_not, "product_path": detected_product_path}


if __name__ == '__main__':
    app.run(host='0.0.0.0')
