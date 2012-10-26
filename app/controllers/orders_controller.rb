# encoding: utf-8

class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new
    
    if @order.save
      redirect_to action: "index", notice: "Заказ создан"
    else
      render action: "new"
    end
  end

end
