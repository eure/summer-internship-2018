Rails.application.routes.draw do
  get 'trends/index' => 'trends#index'
  get 'trends/repository' => 'trends#index'
  
  # API用ルーティング
  namespace :api, format: 'json' do
    namespace :v1 do
      namespace :trends do
        # githubのトレンドをリスト形式で表示するページへ遷移
        get "/", :action => "index"
        # githubのレポジトリの詳細を表示するページへ遷移
        get "/repository", :action => "show"
      end
    end
  end
  get '/' => 'home#top'
  get 'about' => 'home#top'
end
