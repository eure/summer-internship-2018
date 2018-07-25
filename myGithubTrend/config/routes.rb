Rails.application.routes.draw do
  get 'trends/get_trends'
  resources :trends
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
