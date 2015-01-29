class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates :body, presence: true
end
