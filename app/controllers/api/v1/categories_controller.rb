module API
  module V1
    class CategoriesController < BaseController
      respond_to :json

      def index
        if params[:id].present?
          respond_with Category.where(id: params[:id])
        else
          respond_with Category.all
        end
      end

       def show
         respond_with Category.find(params[:id])
       end

      def create
        category = Category.new(category_params)
        if category.save
          render json: category, status: :created, location: [:api, :v1, category]
        else
          render json: { errors: category.errors }, status: :unprocessable_entity
        end
      end

      def update
        category = Category.find(params[:id])
        if category.update(category_params) # TODO: Net::SMTPAuthenticationError
          render json: category, status: :ok, location: [:api, :v1, category]
        else
          render json: { errors: category.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        Category.find(params[:id]).destroy
        head :no_content
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
