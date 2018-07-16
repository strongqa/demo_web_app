class CreateCategoryService
  def call
    Category.find_or_create_by!(name: FFaker::Product.brand)
  end
end
