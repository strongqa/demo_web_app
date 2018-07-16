class Tag < ApplicationRecord
  has_many :articles_tags, dependent: :destroy
  has_many :articles, through: :articles_tags
end
