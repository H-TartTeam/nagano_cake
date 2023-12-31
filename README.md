# ECサイト　ながのケーキ
## DMMWEBCAMP　チーム開発（3名）

## 概要
長野県にある洋菓子店「ながのCAKE」の商品の通販をイメージしたECサイト。 <br>
このECサイトはDMM WEB CAMP生によるチーム開発課題です。<br>

### ◆案件の背景
元々近隣住民が顧客だったが、昨年始めたInstagramから人気となり、全国から注文が来るよう
になりました。<br>
InstagramのDMやメールで通販の注文を受けていましたが、<br>
情報管理が煩雑になってきたため、管理機能を含んだ通販サイトを開設しようと思い至りました。

## ECサイト　一部サンプル画像・動画


1.トップページhttps://github.com/H-TartTeam/nagano_cake/assets/135565720/c11a4c63-b472-4349-8e65-9a9a53707a9b

![image](https://user-images.githubusercontent.com/135565720/256726401-4959851c-ea20-4aa0-9ab1-c9c4579890d3.jpg)

2.キーワード検索
https://github.com/H-TartTeam/nagano_cake/assets/135565720/123adaee-9705-4142-bd69-c0365cbb7667

**顧客側**
- 会員登録、ログイン・ログアウト、退会
- 会員情報の編集
- カートへの追加、商品購入
- 支払い方法、配送先の指定
- 注文履歴の閲覧
- キーワード検索
- ジャンル検索

**管理者側**
- 商品の新規追加、編集、閲覧
- 商品情報の編集
- 会員登録されているユーザ

**使用したGem**
 - Bootstrap(デザイン)
 - devise(登録/退会/ログイン/ログアウト)
 - enum-help(ステータス関連)
 - kaminari(ページネーション)
 - ransack(キーワード検索)

## 開発期間
2023/7/11~2023/7/28

## 開発環境
- 統合開発環境: AWS cloud9
- 開発言語: Ruby 3.1.2
- フレームワーク: Rails 6.1.7.4

## 使用方法
$ git clone git@github.com:H-TartTeam/nagano_cake.git<br>
$ cd nagano-cake<br>
$ rails db:migrate<br>
$ rails db:seed<br>
$ yarn install<br>
$ bundle install<br>
$ rails s

管理者ページのログイン（/admin/sign_in)<br>
初期段階での管理者ページのログインに必要なメールアドレス及びパスワードは下記の通りです。<br>
URLの後ろに/admin/sign_inをつけてください。

メールアドレス：tarte@team
パスワード:202306
