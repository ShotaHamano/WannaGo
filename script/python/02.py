# -*- coding: utf-8 -*-
'''
MySQLテーブルを作成する
'''
import sys
import MySQLdb

db_name = sys.argv[1]
tb_name = sys.argv[2]

FIELD = 'FIELD/FIELD.txt'
field = ''

with open(FIELD, 'r') as template:
    for line in template:
        field += line
table = tb_name + field

db = MySQLdb.connect(host="localhost", user="root", passwd="root")
cursor = db.cursor()
command = 'CREATE TABLE IF NOT EXISTS %s.%s' % (db_name, table)
cursor.execute(command)
cursor.close()mysql