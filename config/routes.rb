Rails.application.routes.draw do
  root 'githubs#index'
  get 'githubs/show'
  get 'githubs/developers'
  get 'githubs/developer'
end
