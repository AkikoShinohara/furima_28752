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
| last_name(kana)    | string   | null: false       |
| first_name(kana)   | string   | null: false       |
| birthday           | date     | null: false       |

### Association

- has_many :items
- has_many :payments

## items テーブル

| Column           | Type       | Options                         |
| ---------------- | ---------- | ------------------------------- |
| name             | string     | null: false                     |
| messages         | text       | null: false                     |
| category_id      | integer    | null: false                     |
| condition_id     | integer    | null: false                     |  
| shipping_cost_id | integer    | null: false                     |
| prefectures_id   | integer    | null: false                     |  
| send_days_id     | integer    | null: false                     |
| price            | integer    | null: false                     | 
| user             | references | null: false , foreign_key: true |

### Association

- has_one  :payment
- has_one_attached :image
- belongs_to: user

## ActiveHashを用いるモデル
- class Category
- class Condition
- class ShoppingCost
- class Prefecture
- class SendDay



## ship_addresses テーブル

| Column         | Type      | Options                        |
| -------------- | --------- | ------------------------------ |
| postal_code    | string    | null: false                    |
| prefectures_id | integer   | null: false                    |
| cities         | string    | null: false                    |
| address        | string    | null: false                    |
| building       | string    |                                |
| phone_number   | string    | null: false                    |
| user           | reference | null: false, foreign_key: true |

### Association

- belong_to :payment

## ActiveHashを用いるモデル
- class Prefecture


## payments テーブル

| Column   | Type     | Option                        |
| -------- | -------- |------------------------------ |
| user_id  | integer  | null:false, foreign_key: true |
| item_id  | integer  | null:false, foreign_key: true |

### Association
- has_one:ship_address
- belongs_to:user
- belongs_to:item



----------------------------------------------------------------
## commentsテーブル（追加実装後の機能）

| Column | Type       | Options                        | 
| ------ | ---------- | ------------------------------ |
| user   | reference  | null: false, foreign_key: true |
| item   | reference  | null: false, foreign_key: true |

### Association

- belong_to :user
- belong_to :item
