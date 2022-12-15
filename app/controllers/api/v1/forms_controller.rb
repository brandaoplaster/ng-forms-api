module Api::V1
  class FormsController < Api::V1::ApiController
    def index
      @forms = current_api_v1_user.forms
      render json: @forms.to_json
    end

    def show
    end

    def update
    end

    def create
    end

    def destroy
    end
  end
end
