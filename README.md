# 納入仕様書管理システム
## 概要
## 本番環境
## 制作背景
## DEMO
### 工夫した点
### 使用技術（開発環境）
### 今後実装したい機能

## DB設計
### usersテーブル
|Column|Type|Option|
|------|----|------|
|email|string|null: false, unique: true|
|password|string|null: false|
#### Association
- has_many :documents
- has_many :companies, through: :documents
- has_many :item, through: :documents

### companiesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|office|string|
#### Association
- has_many :documents
- has_many :user, through: :documents
- has_many :item, through: :documents

### itemsテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|code|integer|null: false|
#### Association
- has_many :documents
- has_many :user, through: :documents
- has_many :companies, through: :documents

### documentsテーブル
|Column|Type|Option|
|------|----|------|
|date|integer|null: false|
|author|string|null: false|
|image|string|null: false|
|note|text|
|user_id|integer|null: false, foreign_key: true|
|company_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
#### Association
- belongs_to :user
- belongs_to :company
- belongs_to :item

