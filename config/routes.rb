Rails.application.routes.draw do
  get 'trends/index'

  get '/' => 'home#top'
  get 'about' => 'home#top'
  get 'trends/index' => 'trends#index'
end
