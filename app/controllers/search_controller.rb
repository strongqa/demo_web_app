class SearchController < ApplicationController
  def index
    @articles = Article.where('title like ?', "%#{search_string}%").page.per(5)
    @q = search_string
  end

  private

  def search_string
    params[:q]
  end
end
