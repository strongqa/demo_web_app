class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.text :body
      t.references :article, index: true

      t.timestamps
    end
  end
end
