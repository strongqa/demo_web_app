class ArticlesController < ApplicationController
  before_action :signed_in_as_admin?, except: [:show, :index]
  layout 'application'

  def index
    @articles = Article.page(params[:page]).per(5)
    @categories = Category.joins(:articles).group(:id).order('COUNT(articles.id) DESC').limit(10)
    @recent_posts = Article.order('created_at DESC').limit(3)
    @popular_tags = Tag.joins(:articles).group(:id).order('COUNT(articles.id) DESC').limit(10)
    add_breadcrumb 'Articles'

    render layout: 'articles/articles'
  end

  def new
    @article = Article.new
    add_breadcrumb 'Articles', articles_path
    add_breadcrumb 'New article'
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = 'New article has been created.'
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    add_breadcrumb 'Articles', articles_path
    add_breadcrumb "Edit #{@article.title}"
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
    add_breadcrumb 'Articles', articles_path
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
    params.require(:article).permit(:title, :text, :image_filename, :category_id, :tag_list)
  end
end
