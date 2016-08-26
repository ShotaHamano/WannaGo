# -*- coding: utf-8 -*-
'''
Flickr APIを用いてクローリングする
'''
import urllib
import simplejson
import MySQLdb
import os
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

###########################
# URLから画像を取得する関数 #
###########################

#検索するtag
#keywords = ['The London Dungeon','DreamWorks Tours Shreks Adventure! London','Winter Wonderland']

table = sys.argv[2]
dbname = sys.argv[1]
key = sys.argv[2]

keywords = [sys.argv[2]]

#dbに応じた候補タグのリストを持ってくる→keywordに格納

#取得する枚数(MAX:250)
photo_num = sys.argv[3]

#取得データを格納するリスト
#まだ増やせるかも...
title = []           #タイトル(str)
photo_id = []        #写真ID(str)
description = []     #説明(str)
tags = []            #タグ(str)
machine_tags = []    #機械タグ(str)
url_o = []             #画像のURL(str)
extra_info = 'title, description, tags, machine_tags, url_o'

#'description,geo,tags,machine_tags,date_upload,owner_name,date_taken,media,views,url_o,last_update'
################geotag narrow

#################################    
# 画像情報を検索し、JSON形式で取得 #
#################################

print "画像を検索して情報を取得しています..."
for tag in keywords:
  print '  「' + tag + '」の画像を取得中...'
  args = { 'method'  : 'flickr.photos.search',
           'api_key'        : 'e6d1eb51f86104912a099becc9d41e67',   #APIkey
           'per_page'       : photo_num,                            #何枚取得するか
           'format'         : 'json',                               #取得するフォーマット
           'nojsoncallback' : 1,
           'extras'         : extra_info,                           #追加取得情報
           'tags'           : tag,                                  #このテキストで全文検索
           'tag_mode'       : 'all',
           'media'          : 'photos',                             #取得するのは画像のみ
           'sort'           : 'relevance',
           'page'           : 1
           }
  URL = "https://api.flickr.com/services/rest/?%s"%(urllib.urlencode(args) )
  photos = simplejson.loads( urllib.urlopen(URL).readline() )
  total =  photos['photos']['total']
  print total
  ########################################
  # 取得した画像情報JSONを解析しリストへ保存 #
  ########################################
  #各データを取得し、リストへ保存
  for data in photos['photos']['photo']:
    if data.has_key('url_o') == False:
      continue
    if str(data['tags']) != '':
      title.append(data['title'])
      photo_id.append(data['id'])
      description.append(str(data['description'])[15:-2])
      tags.append(str(data['tags']))
      machine_tags.append(str(data['machine_tags']))
      url_o.append(data['url_o'])

  if total > 250:
    roop = int(int(total) / 250)
    if int(total)%250 != 0:
      roop += 1
    if roop > 8:
      roop = 8
    for i in range(1,roop):
      args = { 'method'  : 'flickr.photos.search',
           'api_key'        : 'e6d1eb51f86104912a099becc9d41e67',   #APIkey
           'per_page'       : photo_num,                            #何枚取得するか
           'format'         : 'json',                               #取得するフォーマット
           'nojsoncallback' : 1,
           'extras'         : extra_info,                           #追加取得情報
           'tags'           : tag,                                  #このテキストで全文検索
           'tag_mode'       : 'all',
           'media'          : 'photos',                             #取得するのは画像のみ
           'sort'           : 'relevance',
           'page'           : i+1
           }
      URL = "https://api.flickr.com/services/rest/?%s"%(urllib.urlencode(args) )
      photos = simplejson.loads( urllib.urlopen(URL).readline() )
      total =  photos['photos']['total']

      for data in photos['photos']['photo']:
        if data.has_key('url_o') == False:
          continue
        if str(data['tags']) != '':
          title.append(data['title'])
          photo_id.append(data['id'])
          description.append(str(data['description'])[15:-2])
          tags.append(str(data['tags']))
          machine_tags.append(str(data['machine_tags']))
          url_o.append(data['url_o'])
print len(title)


print "データベースへ保存しています..." 
#MySQL(DB)に接続してカーソルを取得
connect = MySQLdb.connect(host = "localhost", db = dbname, user = "root", passwd = 'root')
connect.cursorclass = MySQLdb.cursors.DictCursor
cursor = connect.cursor()

#テーブルに値をINSERTする
i = 0
for data in photo_id:
  cursor.execute('INSERT INTO '+ table+'(title,id,description,tags,machine_tags,url) VALUES(%s,%s,%s,%s,%s,%s)',(title[i].encode('utf-8'),data.encode('utf-8'),description[i].encode('utf-8'),tags[i].encode('utf-8'),machine_tags[i].encode('utf-8'),url_o[i].encode('utf-8')))
  i = i + 1
#DBに反映するために必要な処理
connect.commit()

cursor.close()
connect.close()

#######
# END #
#######
