# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :entry do |f|
    f.start_date { Time.now - 1.hour }
    f.end_date { Time.now }

    trait :valid do
      start_date { Time.now - 1.hour }
      end_date { Time.now }
    end

    trait :in_the_future do
      start_date { 2.days.from_now }
      end_date { 2.days.from_now }
    end

    trait :in_the_past do
      start_date { 2.days.ago }
      end_date { 2.days.ago }
    end
  end
end
