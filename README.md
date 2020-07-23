# 納入仕様書管理アプリ
## 概要
### 納入仕様書とは
製品を製造、販売する際に、納入側(製造側)が購入側(顧客)に提出する文書の一つです。記載内容は多岐にわたり、例えば「製品仕様、納期、運用方法、取引先情報」などがあります。両社が納得のいく合意点を見つけながら作成が行われます。

[参考ページ1](https://seihin-sekkei.com/method/delivery-specification/#:~:text=%E7%B4%8D%E5%85%A5%E4%BB%95%E6%A7%98%E6%9B%B8%E3%81%AF%E8%87%AA%E7%A4%BE,%E3%81%8C%E7%B4%8D%E5%85%A5%E4%BB%95%E6%A7%98%E6%9B%B8%E3%81%A7%E3%81%99%E3%80%82)

[参考ページ2](https://tecdlab.com/2019/02/05/%E7%B4%8D%E5%85%A5%E4%BB%95%E6%A7%98%E6%9B%B8%E3%81%A3%E3%81%A6%E4%BD%95%EF%BC%9F%EF%BD%9E%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%AE%E7%B4%8D%E5%85%A5%E4%BB%95%E6%A7%98%E6%9B%B8%EF%BD%9E/)
### 出来ること
納入側の仕様書を管理することを想定しています。
納入仕様書を保存、閲覧ができます。
会社名（顧客名）と製品名から保存した納入仕様書を検索し、詳細ページでは更新履歴の確認が行えます。

## 本番環境
### URL
### テストアカウント
email：test@test.test<br>
password：testtest

## 制作背景
前職の経験から納入仕様書の管理が煩雑だったたこと、社内外で同じような悩みの人が多かったためです。またこのようなシステムは各社のシステム部が作っていることが多いと思いますが、標準的なものがあった方が良いと思いました。

## DEMO
### 工夫した点
会社名（顧客）、製品名から納入仕様書を検索できるようにしました。
テーブル間のリレーションが、documentsテーブル（納入仕様書）に対してusersテーブル、companiesテーブル（会社情報）、itemsテーブル（製品情報）が多対一になっています。そのため、納入仕様書登録画面ではデータの保存に苦労し、同時に登録できるよう工夫しました。
見た目についてはまだまだですが、直感的に調べられるよう、できるだけシンプルにしました。
### 使用技術（開発環境）
### 今後実装したい機能
納入仕様書管理だけではなく、作成するシステムまで広げたいです。
#### 1. 管理の面
- 購入側から、納入仕様書の管理ができる
#### 2. 作成の面
- 社内稟議が取れる
- 取引先（顧客、代理店、製造元）とのやりとりができる
### 3. 見た目
- 色使いを工夫して見やすくする。
- より良いバランスを考えて修正する。


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

