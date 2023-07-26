Admin.create!(
  email: 'tarte@team',
  password: '202306'
)
#二回目rails db:seedするときは、元々登録してた記述をコメントアウトする

#ジャンルカラム記述
#Genre.create!(name: 'ケーキ')
#Genre.create!(name: 'アニバーサリーケーキ')
#Genre.create!(name: '焼き菓子')
#Genre.create!(name: 'プリン')
#Genre.create!(name: 'キャンディ')
#Genre.create!(name: 'ドーナツ')


#Customer.create!(
  #email: 'hanako@com',
  #password: '887755',
  #last_name: '山田',
  #first_name: '花子',
  #last_kana_name: 'ヤマダ',
  #first_kana_name: 'ハナコ',
  #address: '東京都目黒区中目黒8',
  #postcode: '8888888',
  #phone_number: '7777777'
#)

#アイテムカラム記述
#item = Item.create!(
   #name: "いちごのショートケーキ",
   #introduction: "当店で一番人気のあるいちごのショートケーキです♪とてもオススメです♡",
   #genre_id: 1, # ジャンルのIDを指定
   #is_available: true,
   #price: 500,
  #)

 #モデルファイルにimageのバリデーションをつけるとエラーが起きるのでつけないこと。
 #画像がない場合の記述をしておくこと
 #item.image.attach(io: File.open(Rails.root.join('./app/assets/images/shortcake.jpg')),filename:'shortcake.jpg')


