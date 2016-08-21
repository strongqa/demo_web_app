class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :created_at, :updated_at
end
