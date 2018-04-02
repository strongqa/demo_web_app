class AddImageFilenameToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :image_filename, :string
  end
end
