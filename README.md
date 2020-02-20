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

# フリマアプリ　データベース仕様

## orderテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|user_id|integer|null: false, foreign_key|
|item_id|integer|null: false, foreign_key|
|delivary_date|datetime|null: false|
|credit_id|integer|null: false, foreign_key|
|status|bool|null: false|
### Asociation
- belong_to :user
- belong_to :credit_card
- belong_to :item

## favoriteテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|user_id|integer|null: false, foreign_key|
|item_id|integer|null: false, foreign_key|
### Asociation
- belong_to :user
- belong_to :item

## commentテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|item_id|integer|null: false, foreign_key|
|user_id|integer|null: false, foreign_key|
|comment|text|null: false|
### Asociation
- belong_to :user
- belong_to :item



## shopping_addressテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_cord|string|null: false|
|prefecture|integer|null: false|
|cities|integer|null: false|
|address|string|null: false|
|building_name|string|null: false|
|phone_number|string||

### Association
- belongs_to :user

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|nickname|string|null: false|
|email|string|null: false, unique|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
|phone_number|string||
|photo_filepass|text||

### Association
- has_many :shopping_addresses
- has_many :credit_cards
- has_many :orders
- has_many :favotites
- has_many :comments


## credit_cardテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user
- has_many :orders


## Itemテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|name|string|null: false|
|discription|text||
|price|integer|null: false|
|condition|integer|null: false|
|size|integer||
|preparation_day|integer|null: false| 
|status|boolean|null: false|
|area|int|null: false|
|delivary_fee|int|null: false|
|user_id|integer|foreign_key|
|category_id|integer|foreign_key|
|brand_id|integer|foreign_key,optional|

#### AddIndex
- add_index :name, discription, category_id, size, bland_id, condition, delivary_fee, price, status


### Asociation

- has_one :order(orderキャンセル時はレコードを削除する。)
- has_many :favorites
- has_many :comments
- has_many :images
- belongs_to :categories
- belongs_to :brand

## Brandテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|name|string|null: false, Unique|



### Association

- has_many :categories, through: brand_categories
- has_many :brand_categories

## Categoryテーブル


|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|name|string|null: false, Unique|
|size|bool|null: false|
|parrent_id|integer|foreign_key, optional|



### Association
- has_many :items
- has_many :brands, through: brand_categories
- has_many :brand_categories
- has_many :children (自身の子カテゴリを所持。モデルは自身を参照する。)
- belongs_to :parrent(モデルは自身を参照する。)

## Brand_categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|brand_id|integer|foreign_key|
|category_id|integer|foreign_key|

### Association

- belongs_to :brand
- belongs_to :category

## Imageテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primary_key|
|path|text|null: false|
|item_id|integer|foreign_key|


### Association

- belongs_to :items


