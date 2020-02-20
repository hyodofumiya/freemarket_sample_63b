# フリマアプリデータベースについて

## Itemテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primaryKey|
|name|string|NotNull|
|discription|text||
|price|integer|NotNull|
|condition|integer|NotNull|
|size|integer||
|preparation_day|integer|NotNull| 
|status|boolean|NotNull|
|area|int|NotNull|
|delivary_fee|int|NotNull|
|user_id|integer|foreign_key|
|category_id|integer|foreign_key|
|brand_id|integer|foreign_key,optional|

#### AddIndex
- add_index :name, discription, category_id, size, bland_id, condition, delivary_fee, price, status

#### Asociation

- has_one :order(orderキャンセル時はレコードを削除する。)
- has_many :favorites
- has_many :comments
- has_many :images
- belongs_to :categories
- belongs_to :brand

## Brandテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primaryKey|
|name|string|NotNull, Unique|



#### Association

- has_many :categories, through: brand_categories
- has_many :brand_categories

## Categoryテーブル


|Column|Type|Options|
|------|----|-------|
|id|integer|primaryKey|
|name|string|NotNull, Unique|
|size|bool|NotNull|
|parrent_id|integer|foreign_key, optional|



#### Association
- has_many :items
- has_many :brands, through: brand_categories
- has_many :brand_categories
- has_many :children (自身の子カテゴリを所持。モデルは自身を参照する。)
- belongs_to :parrent(モデルは自身を参照する。)

## Brand_categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primaryKey|
|brand_id|integer|foreign_key|
|category_id|integer|foreign_key|

#### Association

- belongs_to :brand
- belongs_to :category

## Imageテーブル

|Column|Type|Options|
|------|----|-------|
|id|integer|primaryKey|
|path|text|NotNull|
|item_id|integer|foreign_key|


#### Association

- belongs_to :items

