module Api::V1
  class QuestionsController < Api::V1::ApiController
    before_action :allow_only_owner, only: [:create]

    def create
      @question = Question.create(question_params.merge(form: @form))
      render json: @question
    end

    private

    def allow_only_owner
      unless current_api_v1_user == @form.user
        render json: {}, status: :forbidden and return
      end
    end
  end
end
