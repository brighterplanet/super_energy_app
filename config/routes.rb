SuperEnergyApp::Application.routes.draw do
  devise_for :users,  :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  devise_scope :user do
    match '/sign_out', :via => :get, :to => 'devise/sessions#destroy'
  end

  resources :pages, :collection => [:dashboard]

  authenticated do
    root :to => 'pages#dashboard'
  end

  root :to => 'pages#home'
end
