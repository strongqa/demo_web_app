class HomeController < ApplicationController
  skip_before_action :require_login
    skip_before_action :require_admin

  def index
    @articles = Article.all
  end
end
