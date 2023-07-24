 Admin.create!(
   email: 'tarte@team',
   password: '202306'
 )

#ジャンルカラム記述
Genre.create!(name: 'ケーキ')
Genre.create!(name: 'アニバーサリーケーキ')
Genre.create!(name: '焼き菓子')
Genre.create!(name: 'プリン')
Genre.create!(name: 'キャンディ')
Genre.create!(name: 'ドーナツ')

#アイテムカラム記述
item = Item.create!(
   name: "いちごのショートケーキ",
   introduction: "当店で一番人気のあるいちごのショートケーキです♪とてもオススメです♡",
   genre_id: 1, # ジャンルのIDを指定
   is_available: true,
   price: 500,
  )
  
 #モデルファイルにimageのバリデーションをつけるとエラーが起きるのでつけないこと。
 #画像がない場合の記述をしておくこと
 item.image.attach(io: File.open(Rails.root.join('./app/assets/images/shortcake.jpg')),filename:'shortcake.jpg')
  
  # {
  #  name: "ブラウニー",
  #  introduction: "ベルギー産のチョコレートをたっぷり使用したブラウニーです♡",
  #  genre_id: 3,
  #  is_available: true,
  #  price: 250,
  #  image: "brownie.jpg"
  # }


#Item.create(
  # name: "商品1",
  # introduction: "説明文",
  # genre_id: 1,
  # is_available: true,
  # price: 1000,
  # image: "image1.jpg"
  # )
 