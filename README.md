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
