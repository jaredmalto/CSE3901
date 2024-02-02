# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'presentations/not_evaluated'
  resources :presentations do
    resources :scores, only: %i[new create] # Nest scores within presentations
  end
  resources :presentations, only: [:index]

  get '/presentations/not_evaluated', to: 'presentations#not_evaluated', as: 'not_evaluated_presentations'
  get 'manage/users', to: 'manage#users', as: :manage_users
  delete 'manage/delete_presentation', to: 'manage#delete_presentation', as: :delete_presentation
  put 'manage/update_presentation/:id', to: 'manage#update_presentation', as: :update_presentation
  match 'manage/delete_user/:id', to: 'manage#delete_user', via: %i[get delete], as: :manage_delete_user

  get '/scores', to: 'scores#index'
  devise_scope :user do
    # get 'manage/delete_user/:id' => "devise/registrations#destroy"
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  resources :grades
  get '/grades', to: 'grades#index', as: 'all_evaluations'
  get 'manage/add_user', to: 'manage#add_user', as: :manage_add_user
  post 'manage/add_user', to: 'manage#create_user'
  get 'manage/create_presentation', to: 'manage#add_presentation', as: :add_presentation
  post 'manage/create_presentation', to: 'manage#create_presentation', as: :create_presentation

end
