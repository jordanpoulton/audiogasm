class MainController < ApplicationController

  def home
  end

  def playlist_page
    @where = params[:where]
    @min_date = params[:min_date]
    @max_date = params[:max_date]
    @what = params[:genre]
  end
end
