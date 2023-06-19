Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth',
  controllers: { registrations: 'users/registrations'}

  root 'components#index'
  resources :user_invitations

  get '*path', to: 'components#index', via: :all
end