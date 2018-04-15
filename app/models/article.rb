class Article < ActiveRecord::Base
  attr_accessor :tag_list
  belongs_to :category
  belongs_to :user

  has_many :articles_tags
  has_many :tags, through: :articles_tags

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates :category, presence: true

  default_scope -> { order('created_at DESC') }

  mount_uploader :image_filename, ArticleImageUploader

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    new_tags = names.split(',') - tag_list.split(',')
    tags << (new_tags).map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
