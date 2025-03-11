# db/seeds.rb

require 'faker'

# Destroy existing data to start fresh
Task.destroy_all
Project.destroy_all
User.destroy_all

# Create multiple users with Faker data
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password123',
    password_confirmation: 'password123'
  )

  # Create projects and tasks for each user
  3.times do |i|
    project = Project.create!(
      name: "Проект #{i + 1}: #{Faker::App.name}",
      description: Faker::Lorem.paragraph(sentence_count: 4),
      created_at: Faker::Date.between(from: 30.days.ago, to: Date.today),
      user: user
    )

    rand(3..5).times do |j|
      Task.create!(
        project: project,
        name: "Завдання #{j + 1}: #{Faker::Lorem.sentence(word_count: 3)}",
        description: Faker::Lorem.paragraph(sentence_count: 2),
        status: %w[new in_progress completed].sample,
        created_at: Faker::Date.between(from: project.created_at, to: Date.today)
      )
    end
  end
end

puts "Created:"
puts "- #{User.count} Users"
puts "- #{Project.count} Projects"
puts "- #{Task.count} Tasks"
