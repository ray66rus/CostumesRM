# encoding: utf-8

class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])
    
    @order.client = Client.find(params[:order_client])
    if !params[:order_costumes].nil?
      params[:order_costumes].each do |costume_id|
        @order.costumes << Costume.find(costume_id)
      end
    end

    if @order.save
      redirect_to action: "index", notice: "Заказ создан"
    else
      render action: "new"
    end
  end

end
