#encoding: utf-8

class ClientsController < ApplicationController
  def new
    @client = Client.new
  end
  
  def index
    @clients = Client.all
  end
  
  def create
    @client = Client.new(params[:client])
    
    respond_to do |format|
      if @client.save
        format.html { redirect_to action: "index", notice: 'Клиент создан' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def delete
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to action: "index", notice: 'Клиент удален' }
    end
  end
  
  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    
    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to action: "index", notice: 'Данные о клиенте обновлены' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
