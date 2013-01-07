#encoding: utf-8

class ClientsController < ApplicationController
  def new
  end
  
  def index
    @clients = @clients.paginate(page: params[:page])
  end
  
  def create
    respond_to do |format|
      if @client.save
        format.html { redirect_to action: "index", notice: 'Клиент создан' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def delete
    @client.destroy
    respond_to do |format|
      format.html { redirect_to action: "index", notice: 'Клиент удален' }
    end
  end
  
  def edit
  end

  def update
    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to action: "index", notice: 'Данные о клиенте обновлены' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
