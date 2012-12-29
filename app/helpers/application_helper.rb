module ApplicationHelper

  def full_title(subtitle)
    base_title = 'Costumes Rent Manager'
    if subtitle.empty?
      base_title
    else
      "#{base_title} | #{subtitle}"
    end
  end
  
  def use_tabbed_view?
    return false if params[:controller] == 'sessions'
    return false if signed_in? && params[:controller] == 'users' && params[:id].to_s == current_user.id.to_s
    return true
  end
end

