class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  default_scope -> { order('created_at DESC') }

  mount_uploader :image_filename, ArticleImageUploader
end
