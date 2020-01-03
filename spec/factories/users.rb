FactoryBot.define do
  factory :user do
    name {"木村拓哉"}
    sequence(:email) {|n| "test#{n}@yahoo.co.jp"}
    password {"11111111"}
  end
end
