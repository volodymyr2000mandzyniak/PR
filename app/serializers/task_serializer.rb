# app/serializers/task_serializer.rb
class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :project_id, :created_at, :updated_at
end