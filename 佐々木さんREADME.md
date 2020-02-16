# フリマサイト　DB設計
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