module Api::V1
  class AnswersController < Api::V1::ApiController
    before_action :set_form

    def index
      @answers = @form.answers
      render json: @answers, include: "questions_answers"
    end

    private

    def set_form
      @form = (@answer) ? @answer.form : Form.find(params[:form_id])
    end
  end
end
