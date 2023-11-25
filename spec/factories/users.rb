FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alpha(number: 10) }
    password_confirmation { password }
    passport_data do
      { number: Faker::Number.number(digits: 10),
        issued_by: Faker::Company.name,
        issued_at: DateTime.now }
    end
  end
end
