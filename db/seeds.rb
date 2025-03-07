# Очистимо базу даних перед створенням нових даних
# Project.destroy_all
# Task.destroy_all

# Створимо 5 проектів
5.times do
  project = Project.create(
    name: Faker::App.name,
    description: Faker::Lorem.paragraph(sentence_count: 4)
  )

  rand(3..5).times do
    Task.create!(
      name: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 2),
      status: %w[new in_progress completed].sample,
      project_id: project.id
    )  
  end
end

puts "Створено #{Project.count} проектів та #{Task.count} завдань."
