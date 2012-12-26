class MainController < ApplicationController
  skip_load_and_authorize_resource
  
  def index
    case params[:main_selected_tab]
    when 'costumes' then
      render 'costumes/index'
    when 'parts' then
      render 'parts/index'
    end
  end
end
