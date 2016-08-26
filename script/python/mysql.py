# -*- coding: utf-8 -*-
###########################################
# 画像データベースから各種情報を取得するクラス #
###########################################

import MySQLdb

class MySQL():
  def __init__(self):
#リストを準備
    self.image_url = []
#    self.longitude = []
#    self.latitude = []
    self.tags = []
    self.label = []
###
###
#    self.table = ['landmark','museums','nature','zoo','amusement']
    self.table = ['sapporo']
###
###
#MySQL(DB)に接続してカーソル取得                                                    
    self.connect = MySQLdb.connect(host = "localhost", db = "sight", user = "root", passwd = 'root')
    self.connect.cursorclass = MySQLdb.cursors.DictCursor
    self.cursor = self.connect.cursor()
    self.label_num = 0
    for t in self.table:
      self.cursor.execute('SELECT * FROM '+t)
      for self.i in iter(self.cursor):
        self.image_url.append(self.i['url'])
        self.tags.append(self.i['tags'].split(' '))
        self.label.append(self.label_num)
      self.label_num += 1
#タグ
  def show_tags(self):
    return self.tags,self.label
#画像
  def show_image(self):
    return self.image_url,self.label
#位置情報
#  def show_geo(self):
#    return self.longitude,self.latitude,self.label
