FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    status { :new }
    association :project

    trait :in_progress do
      status { :in_progress }
    end

    trait :completed do
      status { :completed }
    end
  end
end
