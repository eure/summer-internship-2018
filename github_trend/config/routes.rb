Rails.application.routes.draw do
  resources :repositories, only: %i(index show)

  root to: 'repositories#index'
  get 'repos/:period' => 'repositories#index'
end
