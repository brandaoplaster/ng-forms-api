module Api::V1
  class FormsController < Api::V1::ApiController
    before_action :set_form, only: [:show, :update, :destroy]

    def index
      @forms = current_api_v1_user.forms
      render json: @forms.to_json
    end

    def show
      render json: @form, include: "questions"
    end

    def update
    end

    def create
    end

    def destroy
    end

    private

    def set_form
      @form = From.friendly.find(params[:id])
    end
  end
end
