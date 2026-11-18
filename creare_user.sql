CREATE USER computer_store_user WITH ENCRYPTED PASSWORD :'parola' CREATEDB;
CREATE DATABASE computer_store OWNER computer_store_user ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE computer_store TO computer_store_user;
