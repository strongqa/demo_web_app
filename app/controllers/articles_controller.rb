class ArticlesController < ApplicationController
  before_action :signed_in_as_admin?, except: [:show, :index]
  layout 'application'

  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 1)
    add_breadcrumb "Articles"

    render layout: 'articles/articles'
  end

  def new
    @article = Article.new
    add_breadcrumb "Articles", articles_path
    add_breadcrumb "New article"
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    add_breadcrumb "Articles", articles_path
    add_breadcrumb "Edit " + @article.title.to_s
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
    add_breadcrumb "Articles", articles_path
    add_breadcrumb @article.title

    render layout: 'articles/article'
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
