CostumesRM::Application.routes.draw do
  get "images/new"
  post "images/uploadFile"

  get 'add_image' => 'images#new', :as => :add_image
  get 'upload_image' => 'images#uploadFile', :as => :upload_image
  get 'clients/new' => 'clients#new', :as => :add_client
  get 'clients' => 'clients#index', :as => :list_clients
  delete 'clients/:id' => 'clients#delete', :as => :delete_client
  post 'clients' => 'clients#create', :as => :create_client
  get 'clients/:id/edit' => 'clients#edit', :as => :edit_client
  put 'clients/:id' => 'clients#update', :as => :update_client
  
  get 'parts/new' => 'parts#new', :as => :add_part
  post 'parts' => 'parts#create', :as => :create_part
  get 'parts' => 'parts#index', :as => :list_parts
  get 'parts/:id/edit' => 'parts#edit', :as => :edit_part
  put 'parts/:id' => 'parts#update', :as => :update_part
  delete 'parts/:id' => 'parts#delete', :as => :delete_part

  get 'costumes/new' => 'costumes#new', :as => :add_costume
  post 'costumes' => 'costumes#create', :as => :create_costume
  get 'costumes' => 'costumes#index', :as => :list_costumes
  get 'costumes/:id/edit' => 'costumes#edit', :as => :edit_costume
  put 'costumes/:id' => 'costumes#update', :as => :update_costume
  delete 'costumes/:id' => 'costumes#delete', :as => :delete_costume
  
  get 'orders/new' => 'orders#new', :as => :add_order
  post 'orders' => 'orders#create', :as => :create_order
  get 'orders' => 'orders#index', :as => :list_orders
  get 'orders/:id/edit' => 'orders#edit', :as => :edit_order
  put 'orders/:id' => 'orders#update', :as => :update_order
  delete 'orders/:id' => 'orders#delete', :as => :delete_order
  post 'orders/:id/set_activity_state' => 'orders#set_activity_state', :as => :set_order_activity_state

  resources :users
  match '/signup', to: 'users#new'
  match '/create_user', to: 'users#create'
  match '/user/:id', to: 'users#update', :as => :update_user
  
  resources :sessions, only: [:new, :create, :destroy]
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/signout', to: 'sessions#destroy', via: :get
end
