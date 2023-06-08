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

## users テーブル

| Column             | Type   | Options                   |
| ------------------ |  ------ | -----------               |
| 姓                 | string | null: false               |
| 名                 | string | null: false               |
| email              | string | null: false, unique: true |
| 姓フリガナ           | string | null: false               |
| 名フリガナ           | string | null: false               |
| encrypted_password | string | null: false               |
| dateofbirth        | date   | null: false               |
| nickname           | string | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column                            | Type        | Options                       |
| ------------------                | ------      | -----------                   |
| productname                       | string      | null: false                   |
| description                       | text        | null: false                   |
| category_id                       | integer     | null: false                   |
| status_id                         | integer     | null: false                   |
| shippingcostresponsibility_id     | integer     | null: false                   |
| originregion_id                   | integer     | null: false                   |
| deliverydays_id                   | integer     | null: false                   |
| price                             | integer     | null: false                  |
| user                              | references  | null: false, foreign_key: true|

### Association

- has_one :purchase


## purchase テーブル

| Column                          | Type        | Options                        |
| user                            | references  | null: false, foreign_key: true |
| items                           | references  | null: false, foreign_key: true |

### Association

- has_one :address

## address テーブル

| postalcode                  | string       | null: false                    |
| prefecture_id                  | integer       | null: false                    |
| city                        | string       | null: false                    |
| streetaddress               | string       | null: false                    |
| buildingname                | string       |
| phonenumber                 | string       | null: false                    |

### Association

- belongs_to :purchase