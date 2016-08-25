class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :is_admin, :created_at, :updated_at
end
