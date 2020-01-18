# README

# i sharing app
地図上に写真の撮影地点を登録・表示する情報共有アプリです。

# Description
市職員として水害にあった経験から情報共有することの重要性を実感し作成しました。
* 画像などの必須情報を入力し投稿すると地図上にピンが立ち、どこで撮影した写真なのか地点登録することができます。
* 各投稿に対してコメントすることができます。
* 投稿に対していいね！またはコメントされた時は通知を受け取ることができます。
* 投稿を検索することができます。

# DEMO
[![Image from Gyazo](https://i.gyazo.com/50d4ebb1aca24d741c040ede287a4893.gif)](https://gyazo.com/50d4ebb1aca24d741c040ede287a4893)

# Features
* Google_maps_apiを使用した地図表示と地点登録
* ajaxを使用した非同期処理（画像削除・投稿検索・いいね！機能）
* rails_adminを使用した管理者設定
* omniauthを使用したSNSログイン機能
* capistranoによるAWS EC2への自動デプロイ
* RSpecを使用した単体テスト・統合テスト

# Requirement
* Ruby 2.5.1
* Rails 5.2.3

# Usage
```
接続先情報
URL https://i-sharing-app.com/
テスト用アカウント等
管理者
メールアドレス: aaaa@aaaa.co.jp
パスワード: 11111111
一般
メールアドレス: bbbb@bbbb.co.jp
パスワード: 11111111
```
# Installation
```
$ git clone https://github.com/Hellowold-0703/i_sharing_app.git
$ cd i_sharing_app
$ bundle install
```

# Author
* 橋本良平
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
- has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id'
- has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id'

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
|latitude|integer|null: false|
|longitude|integer|null: false|
|user_id|integer|null: false, foreign_key: true|
|likes_counter|integer|default: 0|

### Association
- belongs_to :user
- has_many :comments
- has_many :images
- has_many :notifications
- has_many :likes
- has_many :liking_users, through: :likes, source: :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|place_id|integer|null: false, foreign_key: true|
|image|text|null: false|

### Association
- belongs_to :place

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|
|place_id|integer|null: false, foreign_key: true|
|user_id|integer|null:false, foreign_key: true|

### Association
- belongs_to :place
- belongs_to :user
- has_many :notifications

## notificationsテーブル
|Column|Type|Options|
|------|----|-------|
|vistor_id|integer|null: false|
|visited_id|integer|null:false|
|place_id|integer|
|comment_id|integer|
|action|string|null:false, default: ""|
|checked|boolean|null:false, default: false|

### Association
- belongs_to :place
- belongs_to :comment
- belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
- belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
