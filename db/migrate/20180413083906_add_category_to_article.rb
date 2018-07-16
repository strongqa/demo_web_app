class AddCategoryToArticle < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :category, foreign_key: true
    add_reference :articles, :user, foreign_key: true
  end
end
