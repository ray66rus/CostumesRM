module ApplicationHelper

def full_title(subtitle)
  base_title = 'Costumes Rent Manager'
  if subtitle.empty?
    base_title
  else
    "#{base_title} | #{subtitle}"
  end
end

end

