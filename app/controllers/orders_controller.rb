# encoding: utf-8

class OrdersController < ApplicationController
  def new
  end

  def create
    @order.client = Client.find(params[:order_client])
    @order.user_id = current_user.id
    if !params[:order_costumes].nil?
      params[:order_costumes].each do |costume_id|
        @order.costumes << Costume.find(costume_id)
      end
    end

    if @order.save
      redirect_to action: "index", notice: t("order.messages.order_created")
    else
      render action: "new"
    end
  end
  
  def index
  end
  
  def delete
    if @order.destroy
      redirect_to action: "index", notice: t("order.messages.order_deleted")
    else
      redirect_to action: "index", notice: t("order.messages.order_cant_be_deleted")
    end
  end
  
  def edit
  end
  
  def update
    @order.client = Client.find(params[:order_client])
    @order.costumes.clear
    if !params[:order_costumes].nil?
      params[:order_costumes].each do |costume_id|
        @order.costumes << Costume.find(costume_id)
      end
    end

    if @order.update_attributes(params[:order])
      redirect_to action: "index", notice: t("order.messages.order_updated")
    else
      render action: "edit"
    end
  end
  
  def set_activity_state
    @order = Order.find(params[:id])
    
    if @order.nil?
      render :json => {:status => "error", :error_message => t("order.messages.order_not_found")}
      return
    end
    
    @order.activity_status = params[:is_active]
    render :json => @order.save ?
      {:status => "ok", :activity => @order.activity_status == "y"} :
      {:status => "error", :error_message => "Can't set activity status"}
  end

end
