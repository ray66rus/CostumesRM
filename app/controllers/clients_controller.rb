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
end
