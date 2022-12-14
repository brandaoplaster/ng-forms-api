class Answer < ApplicationRecord
  belongs_to :form
  has_many :questions_answers, dependent: :destroy

  accepts_nested_attributes_for :questions_answers

  validates :form, presence: true

  def self.create_with_questions(form, questions_answers)
    answer = nil
    ActiveRecord::Base.transaction do
      answer = Answer.create(form: form)
      questions_answers.each do |question_answer|
        answer.questions_answers.create(question_answer.permit(:question_id, :value))
      end
    end
  end
end
