class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :article_id, :created_at, :updated_at
end
