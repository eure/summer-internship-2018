Rails.application.routes.draw do
  root 'github_infos#index'
  resources :github_infos, only: [:index, :show]
end
