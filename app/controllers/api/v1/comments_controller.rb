module API
  module V1
    class CommentsController < BaseController
      respond_to :json

      def index
        respond_with article.comments
      end

      def show
        respond_with comment
      end

      def create
        comment = article.comments.build(comment_params)
        if comment.save
          render json: comment, status: :created, location: [:api, :v1, article, comment]
        else
          render json: { errors: comment.errors }, status: :unprocessable_entity
        end
      end

      def update
        if comment.update(comment_params)
          render json: comment, status: :ok, location: [:api, :v1, article, comment]
        else
          render json: { errors: comment.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        comment.destroy
        head :no_content
      end

      private

      def comment_params
        params.require(:comment).permit(:body, :user_id)
      end

      def article
        Article.find(params[:article_id])
      end

      def comment
        @_comment ||= article.comments.find(params[:id])
      end
    end
  end
end
