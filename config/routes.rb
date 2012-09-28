CostumesRM::Application.routes.draw do
  get "images/new"
  post "images/uploadFile"
  get "clients/new"

  match 'add_image' => 'images#new', :as => :add_image
  match 'upload_image' => 'images#uploadFile', :as => :upload_image
  match 'add_client' => 'clients#new', :as => :add_client

end
