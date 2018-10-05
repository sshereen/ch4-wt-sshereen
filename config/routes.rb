Rails.application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
    
  resources :movies do
    resources :reviews
  end
  
  get 'auth/:provider/callback' => 'sessions#create'
  post 'logout' => 'sessions#destroy'
  get 'auth/failure' => 'sessions#failure'
end
