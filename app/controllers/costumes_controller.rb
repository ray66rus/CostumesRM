# encoding: utf-8

class CostumesController < ApplicationController
  skip_load_and_authorize_resource
  
  def new
    @costume = Costume.new
  end
  
  def create
    @costume = Costume.new(params[:costume]);
    @costume.costume_type = 'complex'
    
    respond_to do |format|
      if @costume.save
        if !params[:pictures].nil?
          _add_picture(@costume, params[:pictures][:new_picture])
        end
        if !params[:parts].nil?
          _add_part(@costume, params[:parts][:new_part])
        end
        format.html { redirect_to action: "index", notice: 'Костюм создан' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def _add_picture(costume, picture)
    if picture.nil?
      return
    end
    costume.pictures.create({ :image => picture });
    costume.save
  end

  def _add_part(costume, part_id)
    if part_id.empty?
      return
    end
    costume.parts << Part.find(part_id)
    costume.save
  end
  
  def index
    @costumes = Costume.all
  end
  
  def delete
    @costume = Costume.find(params[:id])


    if @costume.costume_type == 'simple'
      notice = 'Невозможно удалить простой костюм'
    elsif @costume.destroy
      notice = 'Костюм удален'
    else
      notice = 'Невозможно удалить костюм'
    end

    respond_to do |format|
      format.html { redirect_to action: "index", notice: notice }
    end
  end
  
  def edit
    @costume = Costume.find(params[:id])
    
    if @costume.costume_type == 'simple'
      redirect_to action: "index", notice: 'Невозможно редактировать простой костюм'
    end
  end
  
  def update
    @costume = Costume.find(params[:id])
    respond_to do |format|
      if @costume.update_attributes(params[:costume])
        if !params[:pictures].nil?
          _remove_pictures(@costume, params[:pictures])
          _add_picture(@costume, params[:pictures][:new_picture])
        end
        if !params[:parts].nil?
          _remove_parts(@costume, params[:parts].keys)
          _add_part(@costume, params[:parts][:new_part])
        end
        format.html { redirect_to action: "index", notice: 'Данные о костюме обновлены' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def _remove_pictures(costume, removed_pictures)
    costume.pictures.each_with_index do |picture, i|
      if removed_pictures['picture-' + i.to_s]
        picture.destroy
      end
    end
  end

  def _remove_parts(costume, removed_parts)
    removed_parts.each do |part_id|
      if part_id == 'new_part'
        next
      end
      costume.parts.delete(Part.find(part_id))
    end
  end

end
