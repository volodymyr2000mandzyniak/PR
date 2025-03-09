# db/seeds.rb
Task.destroy_all
Project.destroy_all

5.times do |i|
  project = Project.create!(
    name: "Проект #{i + 1}: #{Faker::App.name}",
    description: Faker::Lorem.paragraph(sentence_count: 4),
    created_at: Time.now - rand(1..30).days
  )

  rand(3..5).times do |j|
    Task.create!(
      project: project,
      name: "Завдання #{j + 1}: #{Faker::Lorem.sentence(word_count: 3)}",
      description: Faker::Lorem.paragraph(sentence_count: 2),
      status: Task.statuses.keys.sample,
      created_at: project.created_at + rand(1..24).hours
    )
  end
end

puts "Створено:"
puts "- #{Project.count} проектів"
puts "- #{Task.count} завдань"