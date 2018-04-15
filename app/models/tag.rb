class Tag < ApplicationRecord
  has_many :articles_tags
  has_many :articles, through: :articles_tags
end
