class GithubInfosController < ApplicationController
  def index
    @githubs = GithubInfo.order("created_at DESC")
  end

  def show
    @github = GithubInfo.find(params[:id])
  end
end
