class Article < ApplicationRecord
  belongs_to :category
  belongs_to :user, optional: true

  has_many :articles_tags, dependent: :destroy
  has_many :tags, through: :articles_tags

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5, allow_blank: true }

  scope :ordered, -> { order('created_at DESC') }
  mount_uploader :image_filename, ArticleImageUploader

  def self.tagged_with(name)
    Tag.find_by!(name:).articles
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    new_tags = names.split(', ') - tag_list.split(', ')
    tags << new_tags.map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
