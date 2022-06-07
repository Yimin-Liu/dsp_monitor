# !/user/bin/env python
# -*- coding:utf-8 -*-
# time: 2022/5/20--09:07
__author__ = 'strive'

from flask import Blueprint

cameras = Blueprint('cameras', __name__, url_prefix="/cameras")

import app.cameras.views

"""
获取rtsp视频流
"""
sxt_host = '114.213.214.241'
sxt_user = 'admin'
sxt_pwd = '1111111a'
videa_type = "h264"
stream = 'Streaming'
channels = 'Channels/101'
sxt_port = 554
rtsp_type = 'rtsp://{}:{}@{}/{}/{}'
rtsp_url = 'rtsp://{}:{}@{}:{}/11'.format(sxt_user, sxt_pwd, sxt_host,sxt_port)