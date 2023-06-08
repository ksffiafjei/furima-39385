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

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| dateofbirth        | date   | null: false |
| nickname           | string | null: false |
| id                 | date   | null: false |

### Association

- has_many :items
- has_many :purchases
- belongs_to :address

## items テーブル

| Column                         | Type        | Options                       |
| ------------------             | ------      | -----------                   |
| productname                    | string      | null: false                   |
| description                    | text        | null: false                   |
| category                       | string      | null: false                   |
| status                         | string      | null: false                   |
| shippingcostresponsibility     | string      | null: false                   |
| originregion                   | string      | null: false                   |
| deliverydays                   | integer     | null: false                   |
| price                          | string      | null: false                   |
| salescommission                | string      | null: false                   |
| profit                         | string      | null: false                   |
| user_id                        | references  | null: false, foreign_key: true|
| id                             | date        | null: false                   |

### Association

- has_one :purchase
- belongs_to :user
- belongs_to :address

## purchase テーブル

| Column                          | Type        | Options                        |
| user_id                         | references  | null: false, foreign_key: true |
| items_id                        | references  | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## address テーブル

| postalcode                  | date       | null: false                    |
| prefecture                  | string     | null: false                    |
| city                        | string     | null: false                    |
| streetaddress               | date       | null: false                    |
| buildingname                | string     | null: false                    |
| phonenumber                 | date       | null: false                    |

### Association

- belongs_to :item
- belongs_to :user
- belongs_to :purchase