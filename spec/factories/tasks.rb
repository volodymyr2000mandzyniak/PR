FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    status { "MyString" }
    project { nil }
  end
end
