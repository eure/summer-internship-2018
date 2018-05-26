Rails.application.routes.draw do
  root 'githubs#index'
  get 'githubs/developers'
end
