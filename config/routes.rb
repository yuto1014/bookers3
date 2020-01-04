Rails.application.routes.draw do
  root 'post_images#top'
  get 'top' => 'post_images#top'
  get 'about' => 'post_images#about'
  get "search" => "users#search"
  get "users/:id/browsing_histories" => "users#browsing_histories"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :browsing_histories
  resources :post_images do
  resources :post_comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end

resources :users do
	member do
		get :following, :followers
	end
end

resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
