class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    #合計金額算出(0=初期化)（sumに小計が足されていく）((小計を計算して合計金額を算出)
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  #カートに商品を追加
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    #フォームに数量指定しないでカートに入レようとしたらの処理
    if @cart_item.quantity.nil?
      redirect_to request.referer, notice: '個数を選択してください'
    end
    #追加しようとした時に同じ商品が存在するかどうかを判断するIF
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      #カートに商品が存在した場合
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      #指定した数量分更新
      cart_item.quantity += params[:cart_item][:quantity].to_i
      cart_item.save
      redirect_to cart_items_path, notice: '選択された個数分を追加しました'
    else
      #カート内に商品が存在しない場合
      @cart_item.save
        redirect_to cart_items_path, notice: 'カートに商品が追加されました'
    end
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  #一つの商品を削除
  def destroy
    current_customer.cart_items.find(params[:id]).destroy
    #遷移前のページのURL取得
    redirect_to request.referer, notice: '該当商品が削除されました'
  end

  #カート内商品を空にする
  def clear
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end


   private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :quantity)
  end

end
