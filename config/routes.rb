CostumesRM::Application.routes.draw do
  get "images/new"
  post "images/uploadFile"

  match 'add_image' => 'images#new', :as => :add_image
  match 'upload_image' => 'images#uploadFile', :as => :upload_image

end
