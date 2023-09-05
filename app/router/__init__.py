# -*- coding:utf-8 -*-

from .config import config_blueprint
from .account import account_blueprint
from .client import client_blueprint

blueprints = [config_blueprint, account_blueprint, client_blueprint]

def register_blueprint(app):
    for bt in blueprints:
        app.register_blueprint(bt)
