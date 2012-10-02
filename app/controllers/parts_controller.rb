# encoding: utf-8

class PartsController < ApplicationController
  def new
    @part = Part.new
  end
  
  def create
    @part = Part.new(params[:part])
    
    respond_to do |format|
      if @part.save
        _set_price_for_attached_costume(@part, params[:price])
        format.html { redirect_to action: "index", notice: 'Часть костюма создана' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def _set_price_for_attached_costume(part, price)
    attached_costume = part.costumes.first
    attached_costume.price = price
    attached_costume.save
  end
  
  def index
    @parts = Part.all
  end
  
  def delete
    @part = Part.find(params[:id])

    respond_to do |format|
      if @part.destroy
        format.html { redirect_to action: "index", notice: 'Часть костюма удалена' }
      else
        format.html { redirect_to action: "index", notice: 'Невозможно удалить часть костюма' }
      end
    end
  end
  
  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    
    respond_to do |format|
      if @part.update_attributes(params[:part])
        _set_price_for_attached_costume(@part, params[:price])
        format.html { redirect_to action: "index", notice: 'Данные о части костюма обновлены' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
