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