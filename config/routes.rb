Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :projects do
    resources :tasks
  end

end
