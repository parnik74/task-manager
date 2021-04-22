# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  # do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount ApplicationApi, at: '/'
  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     resources :projects, only: [:index]
  #   end
  # end
end
