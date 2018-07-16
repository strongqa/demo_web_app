class CreateArticlesTags < ActiveRecord::Migration[5.0]
  def change
    create_table :articles_tags do |t|
      t.references :article, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
