# -*- coding: utf-8 -*-
'''
MySQLデータベースを作成する
'''
import sys
import MySQLdb

db_name = sys.argv[1]
db = MySQLdb.connect(host="localhost", user="root", passwd="root")
cursor = db.cursor()
command = 'CREATE DATABASE IF NOT EXISTS %s' % db_name
cursor.execute(command)
cursor.close()