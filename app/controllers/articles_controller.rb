class ArticlesController < ApplicationController
  def index
    @articles = Article.open.order(:ranking)
    logger.debug @articles.length
  end

  def show
    @article = Article.find(params[:id])
  end
end
