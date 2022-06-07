# !/user/bin/env python
# -*- coding:utf-8 -*-
# time: 2018/3/7--19:52
__author__ = 'strive'

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, TextAreaField, FileField, SelectField, SelectMultipleField
from wtforms.validators import DataRequired, ValidationError, EqualTo, Email, Regexp
from app.models import Admin, Tag, Auth, Role, User, Cameras
from flask import session


class CamRegistForm(FlaskForm):
    """摄像头注册表单"""
    camera_type = StringField(
        label='设备型号',
        description='设备型号',
        render_kw={
            'class': 'form-control input-lg',
            'placeholder': '设备型号, 可不填',
            # 'required':'required'
        }
    )
    ip_addr = StringField(
        label='IP地址',
        validators=[
            DataRequired('请输入IP地址!'),
            Regexp('(\d|[1-9]\d|1\d{2}|2[0-5][0-5])\.(\d|[1-9]\d|1\d{2}|2[0-5][0-5])\.(\d|[1-9]\d|1\d{2}|2[0-5][0-5])\.(\d|[1-9]\d|1\d{2}|2[0-5][0-5])', message='IP地址格式不正确!')
        ],
        description='IP地址',
        render_kw={
            'class': 'form-control input-lg',
            'placeholder': 'IP地址',
            # 'required': 'required'
        }
    )
    # 修改了手机号码正则表达式
    rstp_port = StringField(
        label='RSTP端口号',
        validators=[
            # 0-65535
            Regexp('[0-9]|[1-9]\d{1,3}|[1-5]\d{4}|6[0-5]{2}[0-3][0-5]', message='端口号格式不正确!')
        ],
        description='RSTP端口号，不知道请默认554',
        render_kw={
            'class': 'form-control input-lg',
            'placeholder': '554',
            # 'required': 'required'
        }
    )
    submit = SubmitField(
        '注册摄像头',
        render_kw={
            'class': 'btn btn-lg btn-success btn-block'
        }
    )

    # 通过下面的验证函数不好使,还是放在views中验证比较好!

    def validata_ip_addr(self, field):
        """查询ip地址是否存在"""
        ip_addr = field.data
        cam = Cameras.query.filter_by(ip_addr=ip_addr).count()
        if ip_addr == 1:
            raise ValidationError('此IP摄像头已存在!')