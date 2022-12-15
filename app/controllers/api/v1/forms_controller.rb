module Api::V1
  class FormsController < Api::V1::ApiController
    before_action :set_form, only: [:show, :update, :destroy]
    before_action :allow_only_owner, only: [:update, :destroy]

    def index
      @forms = current_api_v1_user.forms
      render json: @forms.to_json
    end

    def show
      render json: @form, include: "questions"
    end

    def create
      @form = Form.create(form_params)
      render json: @form
    end

    def update
      @form.update(form_params)
      render json: @form
    end

    def destroy
    end

    private

    def set_form
      @form = From.friendly.find(params[:id])
    end

    def allow_only_owner
      unless current_api_v1_user == @form.user
        render json: {}, status: :forbidden and return
      end
    end

    def form_params
      params.required(:form).permit(:title, :description, :enable, :primary_color).merge(user: current_api_v1_user)
    end
  end
end
