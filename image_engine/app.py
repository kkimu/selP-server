import flask
import cv2
import glob
import numpy as np

app = flask.Flask(__name__)

@app.route('/')
def index():
    return "Hello, World!"

@app.route('/image/<path>')
def image(path):
    image_path="/static/campaign/" + path
    aaa = check_jidori(image_path)
    return str(aaa)


def check_jidori(image_path="/pics/jidori/ocha2.jpg", products_path="/static/canpaign/", folder_path="pics/output"):

    # 変数
    face_detect_or_not = False
    product_path = ""

    # 顔画像の学習データ
    cascade_path = "haarcascade_frontalface_alt.xml"

    #ファイル読み込み
    image = cv2.imread(image_path)

    #グレースケール変換
    image_gray = cv2.cvtColor(image, 0)

    #カスケード分類器の特徴量を取得する
    cascade = cv2.CascadeClassifier(cascade_path)

    # 物体認識（顔認識）の実行
    # image – CV_8U 型の行列．ここに格納されている画像中から物体が検出されます
    # objects – 矩形を要素とするベクトル．それぞれの矩形は，検出した物体を含みます
    # scaleFactor – 各画像スケールにおける縮小量を表します
    # minNeighbors – 物体候補となる矩形は，最低でもこの数だけの近傍矩形を含む必要があります
    # flags – このパラメータは，新しいカスケードでは利用されません．古いカスケードに対しては，
    # cvHaarDetectObjects 関数の場合と同じ意味を持ちます
    # minSize – 物体が取り得る最小サイズ．これよりも小さい物体は無視されます
    facerect = cascade.detectMultiScale(image_gray, scaleFactor=1.1, minNeighbors=1, minSize=(1, 1))

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

    for path in glob.glob('/static/campaign/*'):
        img1 = cv2.imread(path)
        gray = cv2.cvtColor(img1, 0)
        kp1, des1 = detector.detectAndCompute(gray, None)

        # 画像への特徴点の書き込み
        matches = bf.match(des1, des2)
        matches = sorted(matches, key = lambda x:x.distance)

        # store all the good matches as per Lowe's ratio test.
        good = []
        for m in matches:
            if m.distance < 80:
                good.append(m)

        if len(good)>7:
            #print("マッチしました。%s" % path)
            product_path = path

            #draw_params = dict(matchColor = (0,255,0), singlePointColor = None, matchesMask = matchesMask, flags = 2)

            break
        else:
            #print("マッチしませんでした！")
            #matchesMask = None
            pass

    return {"face":face_detect_or_not, "canpaign_file_path":product_path}


if __name__ == '__main__':
   app.run(host='0.0.0.0')
