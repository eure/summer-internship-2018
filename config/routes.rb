Rails.application.routes.draw do
  get '/' => 'home#top'
  get 'about' => 'home#top'
  get 'trends/index' => 'home#top'
end
