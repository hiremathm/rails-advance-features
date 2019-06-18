Rails.application.routes.draw do

  	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  	# resources :products do
  	# 	collection { post :q, to: 'products#index' }
   #  end

  	root 'pages#home_page'
    # resources :pages
  	resources :products

  	resources :categories

  	post '/import', :to => 'products#import'
    get '/export_excel', :to => 'products#export_excel'
    get '/export_excelx', :to => 'products#export_excelx'
    get '/generate_otp', :to => 'products#generate_otp'
  	get '/verify_otp', :to => 'pages#verify_otp'
    get '/delete_all', :to => 'pages#delete_all'
    get '/home', :to => 'pages#home'
    post '/verify', :to => 'products#verify'
    get '/import_or_export', :to => 'pages#import_or_export'
    get '/find_orders', :to => 'pages#find_orders', :as => :find_orders
    get '/all_products', :to => 'products#all_products', :as => :all_products
    get '/home_page', :to => 'pages#home_page', :as => 'home_page'

end
