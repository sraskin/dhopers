Rails.application.routes.draw do

  get 'static/home'
  get '/about' => 'static#about', as: :about
  get '/contact' => 'static#contact', as: :contact
  get '/terms' => 'static#terms', as: :terms
  get '/team' => 'static#team', as: :team
  get '/how' => 'static#how', as: :how
  get '/faq' => 'static#faq', as: :faq
  get '/press' => 'static#press', as: :press
  get '/pricing' => 'static#pricing', as: :pricing
  get '/policy' => 'static#policy', as: :policy
  get '/downloads' => 'static#downloads', as: :downloads
  get '/coverages' => 'static#coverages', as: :coverages

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static#home'

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
  namespace :customer do
    resources :orders
  end
end
