module API
  module V1
    class ArticlesController < BaseController
      respond_to :json

      def index
        respond_with Article.all
      end

      def show
        respond_with Article.find(params[:id])
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: article, status: :created, location: [:api, :v1, article]
        else
          render json: { errors: article.errors }, status: :unprocessable_entity
        end
      end

      def update
        article = Article.find(params[:id])

        if article.update(article_params)
          render json: article, status: :ok, location: [:api, :v1, article]
        else
          render json: { errors: article.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        Article.find(params[:id]).destroy
        head :no_content
      end

      private

      def article_params
        params.require(:article).permit(:title, :text, :category_id)
      end
    end
  end
end
