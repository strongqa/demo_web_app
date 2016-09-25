class HomeController < ApplicationController
  def index
    set_tab :home
    @articles = Article.page(params[:page]).per(10)
  end
end
