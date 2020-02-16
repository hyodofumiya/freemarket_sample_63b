# フリマアプリデータベースについて

## ○Itemテーブル
* 商品の情報を保存するテーブル

### **◆主要カラム**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|id|integer|primaryKey|rails標準のプライマリキー|
|name|string|NotNull|商品名|
|discription|text||商品についての詳細。出品者が任意で記載|
|price|integer|NotNull|売値|
|condition|integer|NotNull|商品の状態。数値の値によって新品～ジャンクまでを表現する|
|size|integer||商品のサイズ。カテゴリが洋服、靴などのときのみ有効
|preparation_day|integer|NotNull|準備期間。注文後何日で発送可能かを表す。| 
|status|boolean|NotNull|商品が購入可能かを表す。trueで購入可能、falseで完売を表す|
|area|int|NotNull|発送先地域。値は市町村番号が入る。|
|delivary_fee|int|NotNull|**これはオーダーカラム？**|


### **◆外部キー**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|user_id|integer|foreign_key|出品者のID|
|category_id|integer|foreign_key|属するカテゴリのid。属する最も若いカテゴリを所持する|
|brand_id|integer|foreign_key,optional|ブランドのID|



#### **◆他テーブルとの関連**

* has_one :order(orderキャンセル時はレコードを削除する。)
* has_many :favorites
* has_many :comments
* has_many :images
* belongs_to :categories
* belongs_to :brand
<br>
<br>
<br>

## ○Brandテーブル
* 商品につくブランドを保存するテーブル

### **◆主要カラム**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|id|integer|primaryKey|rails標準のプライマリキー|
|name|string|NotNull, Unique|ブランド名|



### **◆外部キー**
* なし



#### **◆他テーブルとの関連**

* has_many :categories, through: brand_categories
* has_many :brand_categories
<br>
<br>
<br>

## ○Categoryテーブル
* 商品のカテゴリを保存するテーブル

### **◆主要カラム**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|id|integer|primaryKey|rails標準のプライマリキー|
|name|string|NotNull, Unique|カテゴリ名|
|size|bool|NotNull|サイズの指定が必要なカテゴリかどうかの真偽値を持つ。trueでサイズ必要|



### **◆外部キー**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|parrent_id|integer|foreign_key, optional|親カテゴリのID。自分自身のテーブルを参照する。|



#### **◆他テーブルとの関連**
* has_many :items
* has_many :brands, through: brand_categories
* has_many :brand_categories
* has_many :children (自身の子カテゴリを所持。モデルは自身を参照する。)
* belongs_to :parrent(モデルは自身を参照する。)
<br>
<br>
<br>

## ○Brand_categoriesテーブル
* BrandテーブルとCategoryテーブルを繋ぐ中間テーブル

### **◆主要カラム**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|id|integer|primaryKey|rails標準のプライマリキー|



### **◆外部キー**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|brand_id|integer|foreign_key|ブランドのID|
|category_id|integer|foreign_key|カテゴリのID|




#### **◆他テーブルとの関連**

* belongs_to :brand
* belongs_to :category
<br>
<br>
<br>

## ○Imageテーブル
* 商品の画像を保存するテーブル

### **◆主要カラム**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|id|integer|primaryKey|rails標準のプライマリキー|
|path|text|NotNull|画像のファイルパス|



### **◆外部キー**

|Column|Type|Options|Description|
|------|----|-------|-----------|
|item_id|integer|foreign_key|アイテムのID|



#### **◆他テーブルとの関連**

* belongs_to :items

