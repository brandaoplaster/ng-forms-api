FactoryBot.define do
  factory :question_answer do
    answer
    question
    value { FFaker::Lorem.phrase }
  end
end
