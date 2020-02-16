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



##　shopping_addressテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|primaryKey|
|family_name|string|NotNull|
|first_name|string|NotNull|
|family_name_kana|string|NotNull|
|first_name_kana|string|NotNull|
|post_cord|string|NotNull|
|prefecture|integer|NotNull|
|cities|integer|NotNull|
|address|string|NotNull|
|building_name|string|NotNull|
|phone_number|string||

### Association
- belongs_to :user

##　usersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|primaryKey|
|nickname|string|NotNull|
|email|string|NotNull, unique|
|password|string|NotNull|
|family_name|string|NotNull|
|first_name|string|NotNull|
|family_name_kana|string|NotNull|
|first_name_kana|string|NotNull|
|birthday|date|NotNull|
|phone_number|string||
|photo_filepass|text||

### Association
- has_many :shopping_addresses
- has_many :credit_cards
- has_many :orders
- has_many :favotites
- has_many :comments


##　credit_cardテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|NotNull, primaryKey|
|user_id|integer|NotNull|
|customer_id|string|NotNull|
|card_id|string|NotNull|

### Association
- belongs_to :user
- has_many :orders