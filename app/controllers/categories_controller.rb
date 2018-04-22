class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(article_params)
    if @category.save
      flash[:notice] = 'New category has been created.'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(article_params)
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.page.per(5)
  end

  def delete
    Category.find(params[:id]).delete
    redirect_to :back
  end

  private

  def article_params
    params.require(:category).permit(:name)
  end
end
