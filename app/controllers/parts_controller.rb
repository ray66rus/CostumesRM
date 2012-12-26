# encoding: utf-8

class PartsController < ApplicationController
  def new
  end
  
  def create
    respond_to do |format|
      if @part.save
        if !params[:pictures].nil?
          _add_picture(@part, c[:new_picture])
        end
        _set_price_for_attached_costume(@part, params[:price])
        format.html { redirect_to action: "index", notice: 'Часть костюма создана' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def _add_picture(part, picture)
    if picture.nil?
      return
    end
    part.pictures.create({ :image => picture });
    part.save
  end
  
  def _set_price_for_attached_costume(part, price)
    attached_costume = part.costumes.first
    attached_costume.price = price
    attached_costume.save
  end
  
  def index
  end
  
  def delete
    respond_to do |format|
      if @part.destroy
        format.html { redirect_to action: "index", notice: 'Часть костюма удалена' }
      else
        format.html { redirect_to action: "index", notice: 'Невозможно удалить часть костюма' }
      end
    end
  end
  
  def edit
  end

  def update
    respond_to do |format|
      if @part.update_attributes(params[:part])
        if !params[:pictures].nil?
          _remove_pictures(@part, params[:pictures])
          _add_picture(@part, params[:pictures][:new_picture])
        end
        _set_price_for_attached_costume(@part, params[:price])
        format.html { redirect_to action: "index", notice: 'Данные о части костюма обновлены' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def _remove_pictures(part, removed_pictures)
    part.pictures.each_with_index do |picture, i|
      if removed_pictures['picture-' + i.to_s]
        picture.destroy
      end
    end
  end
end
