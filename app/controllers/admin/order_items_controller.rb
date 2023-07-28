class Admin::OrderItemsController < ApplicationController

  # 注文商品の制作ステータスを更新するアクション
  def update
    @order_item = OrderItem.find(params[:id]) # パラメーターで指定された注文商品の詳細情報を取得
    @order = @order_item.order # 注文商品に紐づく注文情報を取得
    @order_items = @order.order_items # 注文に紐づく注文商品の一覧を取得
    # 注文商品の制作ステータスを更新
    @order_item.update(order_item_params)
    # 注文に紐づく注文商品の制作ステータス一覧を取得
    @production_statuses = @order_items.pluck(:make_status)
    # もし制作ステータスが制作中の商品が一つでもあれば、注文のステータスを製作中に更新
    @order.update(status: "in_production") if @production_statuses.any? { |val| val == "in_production" }
    # もし制作ステータスがすべて制作完了の商品だけであれば、注文のステータスを発送準備中に更新
    @order.update(status: "preparing_to_ship") if @production_statuses.all? { |val| val == "completion_of_production" }
    redirect_to admin_order_path(@order) # 注文詳細ページにリダイレクトする
  end

  private

  def order_item_params
    params.require(:order_item).permit(:make_status) # 注文商品の制作ステータスを更新する際に許可するパラメーターを指定
  end
end

