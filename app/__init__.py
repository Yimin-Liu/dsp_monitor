# !/user/bin/env python
# -*- coding:utf-8 -*- 
# time: 2018/3/7--19:50
__author__ = 'DSP'

from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
import os
from flask_migrate import Migrate

app = Flask(__name__)
# 配置数据库连接变量
DIALCT = 'mysql'
DRIVER = 'pymysql'
USERNAME = 'root'
PASSWORD = 'root'
HOST = '127.0.0.1'
PORT = '3306'
DBNAME = 'dspmonitor'
SQLALCHEMY_DATABASE_URI = '{}+{}://{}:{}@{}:{}/{}?charset=utf8'.format(DIALCT, DRIVER, USERNAME, PASSWORD, HOST, PORT,
                                                                       DBNAME)
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['UP_DIR'] = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'static/uploads/')  # 定义后台上传的文件的保存路径
app.config['FC_DIR'] = os.path.join(os.path.abspath(os.path.dirname(__file__)),
                                    'static/uploads/users/')  # 定义前台上传的用户头像文件的保存路径

app.debug = False  # 开发调试模式

app.secret_key = 'Henry'  # 密钥:用于csrf加密

# 获取SQLAlchemy对象
db = SQLAlchemy(app)
migrate = Migrate(app, db)

from app.home import home as home_blueprint
from app.admin import admin as admin_blueprint
from app.cameras import cameras as camera_blueprint

# 蓝图注册
app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint, url_prefix='/admin')
app.register_blueprint(camera_blueprint)


# 404页面
@app.errorhandler(404)
def page_not_found(error):
    return render_template('home/404.html'), 404
