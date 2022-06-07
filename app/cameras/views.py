

from . import cameras
from app.models import Cameras
from app.cameras.forms import CamRegistForm
from flask import render_template, url_for, redirect, flash, session, request, Response
from app import db, app
import cv2
from pytorchyolo import detect, models
from pytorchyolo.utils.parse_config import parse_data_config
from pytorchyolo.utils.utils import load_classes
import matplotlib.pyplot as plt
import numpy as np
import torch

model = models.load_model(
    "../../PyTorch-YOLOv3/config/yolov3-tiny.cfg",
    "../../PyTorch-YOLOv3/weights/yolov3-tiny.weights")

name_path = "../../PyTorch-YOLOv3/data/coco.names"


# 拷贝自/home/views

# rtsp = 'rtsp://admin:admin@192.168.3.160:554/1/1'
# camera = cv2.VideoCapture(rtsp)
# camera = cv2.VideoCapture(0)

# sxt_host = '114.213.214.241'
# sxt_user = 'admin'
# sxt_pwd = '1111111a'
# videa_type = "h264"
# stream = 'Streaming'
# sxt_port = 554
# channels = 'Channels/101'
#
# rtsp_type = 'rtsp://{}:{}@{}/{}/{}'
# rtsp_url = 'rtsp://{}:{}@{}:{}/11'.format(sxt_user, sxt_pwd, sxt_host, sxt_port)

"""
获取rtsp视频流
"""
# rtsp_url = 'rtsp://{}:{}@{}/{}/{}'.format(sxt_user, sxt_pwd, sxt_host, stream, channels)
# rtsp_url = 'rtsp://{}:{}@{}:{}/11'.format(sxt_user, sxt_pwd, sxt_host,sxt_port)


def get_rstp_url(rstp_ip, rstp_port):
    rtsp_type = 'rtsp://{}:{}@{}:{}/11'
    sxt_user = 'admin'
    sxt_pwd = '1111111a'
    print(rstp_ip)
    print(rstp_port)
    url = rtsp_type.format(sxt_user, sxt_pwd, rstp_ip, rstp_port)
    print(url)
    return url


def gen_frames(rtsp_url):
    while True:
        camera = cv2.VideoCapture(rtsp_url)
        success, frame = camera.read()
        if not success:
            break
        else:
            img = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            # Runs the YOLO model on the image
            boxes = detect.detect_image(model, img)
            detections = torch.from_numpy(boxes)
            class_names = load_classes(name_path)
            COLORS = np.random.uniform(0, 255, size=(len(class_names), 3))

            for x1, y1, x2, y2, conf, cls_pred in detections:
                label = str(class_names[int(cls_pred)])
                color = COLORS[int(cls_pred)]
                frame = cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)),
                                      color, 2)
                frame = cv2.putText(frame, label, (int(x1) - 10, int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)
            ret, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()

            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')


# @cameras.route('/camera_regisit', methods=['GET', 'POST'])
# def camera_regisit():
#     form = CamRegistForm()
#     if form.validate():
#         data = form.data
#         # 查询用户名是否存在
#         ip_addr = data['ip_addr']
#         cam = Cameras.query.filter_by(ip_addr=ip_addr).count()
#         if cam == 1:
#             flash('此IP地址已存在!', 'err')
#             return render_template('home/regist.html', form=form)
#         cam = Cameras(
#             camera_type=data['camera_type'],
#             ip_addr=data['ip_addr'],
#             rstp_port=data['rstp_port'],
#         )
#         db.session.add(cam)
#         db.session.commit()
#         flash('恭喜您,该摄像机注册成功!', 'ok')
#         return redirect(url_for('cameras.index'))
#     return render_template('cameras/cam_regisit.html', form=form)


@cameras.route('/camera1')
def index():
    cam_id = [1]
    return render_template('home/indexvedio.html', cameras=cam_id)


@cameras.route('/video_feed/<int:id>/', methods=['GET', 'POST'])
def video_feed(id=None):
    camera = Cameras.query.filter_by(id=id).first()
    rstp_url = get_rstp_url(camera.ip_addr, camera.rstp_port)
    return Response(gen_frames(rstp_url), mimetype='multipart/x-mixed-replace; boundary=frame')

