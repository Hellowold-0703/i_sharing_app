# README

# i sharing app
情報共有アプリです。画像などの必須情報を入力し投稿すると地図上にピンが立ち、どこで撮った写真なのか登録することができます。

# DEMO
[![Image from Gyazo](https://i.gyazo.com/50d4ebb1aca24d741c040ede287a4893.gif)](https://gyazo.com/50d4ebb1aca24d741c040ede287a4893)

# Features
* Google_maps_apiを使用した地図表示と地点登録
* ajaxを使用した非同期処理（画像削除・投稿検索・いいね！機能）
* capistranoによるAWS EC2への自動デプロイ
* RSpecを使った単体テスト

# Requirement
* Ruby 2.5.1
* Rails 5.2.3

# Usage
```
$ git clone https://github.com/Hellowold-0703/i_sharing_app.git
$ cd i_sharing_app
$ bundle install
```

# Author
* 橋本　良平
* h.ryohei0703@gmail.com

# License
MIT


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|e-mail|string|null: false, unique: true|
|password|string|null: false|

### Association
- has_many :places
- has_many :comments
- has_many :likes
- has_many :like_places, through: :likes, source: :place

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|place_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :place

## placesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|address|string|null: false|
|description|string|null: false|
|images|string|null: false|
|latitude|integer|null: false|
|longitude|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|likes_counter|integer|

### Association
- belongs_to :user
- has_many :comments
- has_many :likes
- has_many :liking_users, through: :likes, source: :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|
|place_id|integer|null: false, foreign_key: true|
|user_id|integer|null:false, foreign_key: true|

### Association
- belongs_to :place
- belongs_to :user
