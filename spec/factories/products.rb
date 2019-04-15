FactoryBot.define do
  factory :product do
    name { Faker::App.name }
    release_date { Date.today }
    version { Faker::App.version }
    author { Faker::App.author }
    value { Faker::Number.number(5) }
    active { true }
  end
end
