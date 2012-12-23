# encoding: utf-8

class OrdersController < ApplicationController
  skip_load_and_authorize_resource
  
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
      redirect_to action: "index", notice: t("order.messages.order_created")
    else
      render action: "new"
    end
  end
  
  def index
    @orders = Order.all
  end
  
  def delete
    @order = Order.find(params[:id])
    if @order.destroy
      redirect_to action: "index", notice: t("order.messages.order_deleted")
    else
      redirect_to action: "index", notice: t("order.messages.order_cant_be_deleted")
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    
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
