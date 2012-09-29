CostumesRM::Application.routes.draw do
  get "images/new"
  post "images/uploadFile"

  get 'add_image' => 'images#new', :as => :add_image
  get 'upload_image' => 'images#uploadFile', :as => :upload_image
  get 'clients/new' => 'clients#new', :as => :add_client
  get 'clients' => 'clients#index', :as => :list_clients
  post 'clients' => 'clients#create', :as => :client_create

end
