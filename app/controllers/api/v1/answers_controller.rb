module Api::V1
  class AnswersController < Api::V1::ApiController
    before_action :set_form
    before_action :set_answer, only: [:show]
    before_action :allow_only_owner, only: [:index, :show]

    def index
      @answers = @form.answers
      render json: @answers, include: "questions_answers"
    end

    def show
      render json: @answer, include: "questions_answers"
    end

    def create
      @answer = Answer.create_with_questions(@form, params["questions_answers"])
      render json: @answer
    end

    private

    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_form
      @form = (@answer) ? @answer.form : Form.find(params[:form_id])
    end

    def allow_only_owner
      unless current_api_v1_user == @form.user
        render json: {}, status: :forbidden and return
      end
    end
  end
end
