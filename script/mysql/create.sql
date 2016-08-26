/* create database */
CREATE DATABASE wannago;
USE wannago;


/* create tables */
CREATE TABLE pictures(
  picture_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  picture_url TEXT,
  latitude FLOAT,
  longitude FLOAT,
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE plans(
  plan_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  plan_name TEXT,
  plan_detail LONGTEXT,
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE users(
  user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  account TEXT,
  password TEXT,
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE behaviors(
  behavior_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  location_id INT,
  created_at DATETIME,
  updated_at DATETIME
);

CREATE TABLE locations(
  location_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  location_name TEXT,
  description LONGTEXT,
  address TEXT,
  station TEXT,
  created_at DATETIME,
  updated_at DATETIME
);
