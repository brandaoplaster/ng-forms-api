class CreateQuestionAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :question_answers do |t|
      t.references :answer, foreign_key: true
      t.references :question, foreign_key: true
      t.text :value

      t.timestamps
    end
  end
end
