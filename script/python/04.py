# -*- coding:utf-8 -*-
'''
クローリングした画像を保存する
'''
from mysql import *
import urllib
import sys
import os.path
import subprocess

tag = sys.argv[1]
image_num = int(sys.argv[2])

sql = MySQL()
image,label = sql.show_image()











#dirpath = '/media/hamano/HD-CBU2/hamano/data/images/%s/' % tag
if os.path.exists(dirpath) == False:
    command = 'mkdir %s' % dirpath
    subprocess.call(command, shell=True)

num = 0
for i in range(0,image_num):
  savepath = dirpath + ('00000'+str(num))[-5:] + '.jpg'
  urllib.urlretrieve(image[i],savepath)
  num += 1
  print num
