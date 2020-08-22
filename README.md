# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# テーブル設計

## users テーブル

| Column             | Type     | Options           |
| -------------------| -------- | ------------------|
| nickname           | string   | null: false       |
| email              | string   | null: false       |
| encrypted_password | string   | null: false       |
| last_name          | string   | null: false       |
| first_name         | string   | null: false       |
| birthday           | date     | null: false       |

### Association

- has_many :comments
- has_many :items
- has_one  :ship_address


## items テーブル

| Column        | Type       | Options                         |
| ------------- | ---------- | ------------------------------- |
| name          | string     | null: false                     |
| messages      | text       | null: false                     |
| category_id   | integer    | null: false                     |
| send_price_id | integer    | null: false                     |  
| status_id     | integer    | null: false                     |  
| send_area_id  | integer    | null: false                     |
| price         | integer    | null: false                     | 
| user          | references | null: false , foreign_key: true |

### Association

- has_many :comments
- has_one  :payment
- has_one_attached :image

## ActiveHashを用いるモデル
- class Category
- class SendPrice
- class Status
- class SendArea


## commentsテーブル

| Column | Type       | Options                        | 
| ------ | ---------- | ------------------------------ |
| user   | reference  | null: false, foreign_key: true |
| item   | reference  | null: false, foreign_key: true |

### Association

- belong_to :user
- belong_to :item


## ship_address テーブル

| Column       | Type      | Options                        |
| ------------ | --------- | ------------------------------ |
| postal_code  | integer   | null: false                    |
| state_id     | text      | null: false                    |
| address      | string    | null: false                    |
| build        | text      | null: false                    |
| phone_number | string    | null: false                    |
| user_id      | reference | null: false, foreign_key: true |

### Association

- belong_to :user

## ActiveHashを用いるモデル
- class Status
