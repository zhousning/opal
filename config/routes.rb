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


  resources :home, :only => [] do
    get :custom_service, :on => :collection
    get :help, :on => :collection
  end

  resources :extract_cashes, :only => [ :new, :create] 

  resources :share_pools, :only => [:show] do
    get :current_month, :on => :collection
  end
  
  resources :systems, :only => [] do
    get :send_confirm_code, :on => :collection
  end

  resources :pick_records, :only => [:index]

  resources :users, :only => []  do
    get :level, :on => :collection
    get :center, :on => :collection
    get :mobile_authc_new, :on => :member
    post :mobile_authc_create, :on => :member
    get :mobile_authc_status, :on => :member
  end

  resources :orders, :only => [:new, :create] do
    get :pay, :on => :collection
    get :alipay_return, :on => :collection
    post :alipay_notify, :on => :collection
  end

  resources :trade_orders, :only => [:index, :show] do
    post :pay_create, :on => :member
    get :pending, :on => :collection
    get :paid, :on => :collection
    get :departed, :on => :collection
    get :completed, :on => :collection
    get :all, :on => :collection
  end

  resources :citrines, :only => [:index] do
    get :exchange, :on => :collection
    get :info, :on => :collection
  end

  resources :teams, :only => [:index]

  resources :trees, :only => [:index]

  resources :leafs, :only => [] do
    get :pick, :on => :member
  end

  resources :tasks, :only => [] do
    get :invite, :on => :collection
  end

  resources :trades, :only => [:index] do
    get :betray_new, :on => :member
    post :betray_create, :on => :member
    get :buy_new, :on => :member
    post :buy_create, :on => :member
    get :my_demand, :on => :collection
    get :my_sell, :on => :collection
  end

  resources :demands, :only => [:new, :create]
  resources :sells, :only => [:new, :create]

  resources :accounts, :only => [:edit, :update] do
    get :recharge, :on => :collection 
    get :info, :on => :collection
    get :status, :on => :collection
  end

  resources :wares do
    get :mobile_index, :on => :collection
    get :mobile_show, :on => :member
    get :up, :on => :member
    get :down, :on => :member
    resources :trade_orders,:only => [:new, :create]
  end

  resources :notices do
    get :mobile_index, :on => :collection
    get :mobile_show, :on => :member
  end

  resources :roles

  root :to => 'trees#index'
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
