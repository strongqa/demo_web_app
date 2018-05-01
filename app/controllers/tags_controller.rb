class TagsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.page.per(5)
  end
end
