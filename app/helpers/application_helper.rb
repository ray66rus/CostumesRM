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
    return false if in_sessions_controller?
    return false if signed_in? && params[:controller] == 'users' && params[:id].to_s == current_user.id.to_s
    return true
  end

  def in_sessions_controller?
    return in_controller?('sessions')
  end
  
  def in_controller?(controller)
    return params[:controller] == controller
  end

  def in_users_controller?
    return in_controller?('users')
  end
  
  def in_clients_controller?
    return in_controller?('clients')
  end
  
  def in_costumes_controller?
    return in_controller?('costumes')
  end
  
  def in_orders_controller?
    return in_controller?('orders')
  end
  
  def in_parts_controller?
    return in_controller?('parts')
  end
end

