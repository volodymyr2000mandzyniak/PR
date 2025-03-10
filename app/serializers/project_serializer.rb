# app/serializers/project_serializer.rb
class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :user_id
  has_many :tasks
end