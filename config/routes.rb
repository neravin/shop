Rails.application.routes.draw do
  

  resources :clients do
    resources :orders, only: [:index]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories
  resources :vids
  resources :bodies
  resources :users
  resources :orders, only: [:index, :show, :new, :create, :edit] do
    collection do
      patch 'cgange_add'
      patch 'change_decrement'
    end
  end

  resources :line_items
  resources :carts
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :activation_client, only: [:edit, :update]

  match '/registration', to: 'clients#new' , via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/change_add' => 'orders#change_add', via: 'get'
  match '/change_decrement' => 'orders#change_decrement', via: 'get'

  get 'admin' => 'admin#index'
  controller :session do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'session/create'
  get 'session/destroy'

  resources :users

  resources :line_items

  resources :carts

  get 'store/index'

  get 'home/index'
  get 'category/show'

  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'home#index', as: 'home'
  
  resources :products do
    get :who_bought, on: :member
  end

  #get 'clients/new'
  



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
