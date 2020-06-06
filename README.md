# specification-management DB設計
## usersテーブル
|Column|Type|Option|
|------|----|------|
|email|string|null: false, unique: true|
|password|string|null: false|
### Association
- has_many :companies
- has_many :items

## companiesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|office|string|
### Association
- has_many :items, through: :spetifications
- has_many :spetifications

## itemsテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|code|integer|null: false|
### Association
- has_many :companies, through: :spetifications
- has_many :spetifications

## spetificationsテーブル
|Column|Type|Option|
|------|----|------|
|date|string|null: false|
|image|string|
|company_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :company
- belongs_to :item


<!-- ## companies_itemsテーブル
|Column|Type|Option|
|------|----|------|
|company_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :company
- belongs_to :item -->