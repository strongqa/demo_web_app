class SearchController < ApplicationController
  skip_before_action :require_login
    skip_before_action :require_admin

  def index
    if search_string.empty?
      flash[:danger] = "Search field can't be blank"
      redirect_to :articles
    else
      @articles = Article.where('title like ?', "%#{search_string}%").page.per(5)
      @q = search_string
    end
  end

  private

  def search_string
    params[:q]
  end
end
