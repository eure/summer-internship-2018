class RepositoriesController < ApplicationController
  def index
    case params[:period]
    when 'weekly'
      @repos = WeekTrendRepositorie.all
    when 'month'
      @repos = MonthTrendRepositorie.all
    else
      @repos = TodayTrendRepositorie.all
    end
  end

  def show
    @repo = Repositorie.find(params[:id])
  end
end
