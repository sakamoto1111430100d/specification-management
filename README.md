# documents-management DB設計
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
- has_many :items, through: :documents
- has_many :documents

## itemsテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|code|integer|null: false|
### Association
- has_many :companies, through: :documents
- has_many :documents

## documentsテーブル
|Column|Type|Option|
|------|----|------|
|date|integer|null: false|
|author|string|null: false|
|image|string|
|company_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :company
- belongs_to :item

## company-usersテーブル
|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false, foreign_key: true|
|company_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :company

## item-usersテーブル
|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item
