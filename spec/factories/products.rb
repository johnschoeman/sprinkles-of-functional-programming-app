FactoryBot.define do
  factory :product do
    name { Faker::App.name }
    date { Time.current }
    version { Faker::App.version }
    author { Faker::App.author }
    value { Faker::Number.number(5) }
  end
end
