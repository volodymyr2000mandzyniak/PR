# app/serializers/project_serializer.rb
class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at
  has_many :tasks
end