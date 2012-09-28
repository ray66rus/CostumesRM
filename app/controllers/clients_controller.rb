class ClientsController < ApplicationController
  def new
    @client = Client.new
  end
  
  def index
    @client = Client.all
  end
end
