class CommentsController < ApplicationController
  before_action :signed_in_as_admin?
  skip_before_action :require_admin

  def create
    @article = find_article
    @comment = @article.comments.build(comment_params.merge(user: current_user))
    if @article.save
      flash[:notice] = 'Comment was successfully added to current article.'
    else
      flash[:danger] = @comment.errors.full_messages.join
    end
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_article
    Article.find(params[:article_id])
  end
end
