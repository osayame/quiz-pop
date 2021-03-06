Rails.application.routes.draw do
  resources :coins

  match 'buy-coins', to: 'charges#new', via: :get

  resources :charges 

  resources :achievements

  devise_for :admins
  devise_for :users, :controllers => { :omniauth_callbacks => "users/auth" }

  resources :statistics

  get 'welcome/index'

  resources :games do 
    member do
      get 'updateQuestion'
      post 'new_game'
    end
  end
  
  resources :quizzes

  resources :categories do
    resources :questions
  end

  match 'verify', to: 'games#verify', via: :get
  match 'feedback', to: 'games#feedback', via: :get
  match 'specialMode', to: 'games#specialMode', via: :get
  match 'choosePiece', to: 'games#choosePiece', via: :get
  match 'setPiece', to: 'games#setPiece', via: :get

  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
