Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_scope :user do
    # get 'login_validate', to: 'users/sessions#login_validate'
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :users do
    get :control, :on => :collection
    get :mobile_authc_new, :on => :member
    post :mobile_authc_create, :on => :member
    get :mobile_authc_status, :on => :member
    get :pass, :on => :member
    get :reject, :on => :member
  end

  resources :trees do
    get :mobile_index, :on => :collection
  end

  resources :leafs do
    get :pick, :on => :member
  end

  resources :trades, :only => [:index] do
    get :betray_new, :on => :member
    post :betray_create, :on => :member
  end

  resources :demands
  resources :sells

  resources :accounts do
    get :recharge, :on => :collection 
  end

  resources :buyers

  resources :wares do
    get :mobile_index, :on => :collection
    get :mobile_show, :on => :member
    get :up, :on => :member
    get :down, :on => :member
  end

  resources :notices do
    get :mobile_index, :on => :collection
    get :mobile_show, :on => :member
  end

  resources :roles

  root :to => 'home#index'
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
