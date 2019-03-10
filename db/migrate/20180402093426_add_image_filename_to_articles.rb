class AddImageFilenameToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :image_filename, :string
  end
end
