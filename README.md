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
| sei                 | string | null: false               |
| mei                 | string | null: false               |
| email              | string | null: false, unique: true |
| sei_hurigana           | string | null: false               |
| mei_hurigana           | string | null: false               |
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
| prefecture_id                     | integer     | null: false                   |
| deliverydays_id                   | integer     | null: false                   |
| price                             | integer     | null: false                  |
| user                              | references  | null: false, foreign_key: true|

### Association

- has_one :purchase
- belongs_to :user


## purchases テーブル


| Column                          | Type        | Options                        |
| ------------------              | ------      | -----------                    |
| user                            | references  | null: false, foreign_key: true |
| item                           | references  | null: false, foreign_key: true |


### Association

- has_one :address
- belongs_to :user
- belongs_to :item


## address テーブル
| Column                            | Type        | Options                       |
| ------------------                | ------      | -----------                   |
| postalcode                  | string       | null: false                    |
| prefecture_id               | integer      | null: false                   |
| city                        | string       | null: false                    |
| streetaddress               | string       | null: false                    |
| buildingname                | string         |
| phonenumber                 | string       | null: false                    |
| purchase_id                 | references  | null: false, foreign_key: true |

### Association

- belongs_to :purchase

