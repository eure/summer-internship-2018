class TrendsController < ApplicationController
  before_action :set_trend, only: [:show, :edit, :update, :destroy]

  # GET /trends
  # GET /trends.json
  def index
    @trends = Trend.all
  end

  # GET /trends/1
  # GET /trends/1.json
  def show
  end

  # GET /trends/new
  def new
    @trend = Trend.new
  end

  # GET /trends/1/edit
  def edit
  end

  # POST /trends
  # POST /trends.json
  def create
    @trend = Trend.new(trend_params)

    respond_to do |format|
      if @trend.save
        format.html { redirect_to @trend, notice: 'Trend was successfully created.' }
        format.json { render :show, status: :created, location: @trend }
      else
        format.html { render :new }
        format.json { render json: @trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trends/1
  # PATCH/PUT /trends/1.json
  def update
    respond_to do |format|
      if @trend.update(trend_params)
        format.html { redirect_to @trend, notice: 'Trend was successfully updated.' }
        format.json { render :show, status: :ok, location: @trend }
      else
        format.html { render :edit }
        format.json { render json: @trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trends/1
  # DELETE /trends/1.json
  def destroy
    @trend.destroy
    respond_to do |format|
      format.html { redirect_to trends_url, notice: 'Trend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def get_trends
    require 'github-trending'
    @repos = Github::Trending.get
    @mes = ""
    # begin
    #   @repos = Github::Trending.get
    #   @mes = ""
    # rescue
    #   @repos = []
    #   @mes = "failed"
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trend
      @trend = Trend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trend_params
      params.require(:trend).permit(:name, :lang, :description, :star_count, :url)
    end
end
