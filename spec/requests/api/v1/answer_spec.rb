require "rails_helper"

RSpec.describe "Api::V1::Answers", type: :request do
  describe "GET /index" do
    context "with invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :get, "/api/v1/answers"
    end

    context "with valid authentication headers" do
      before do
        @user = create(:user)
        @form = create(:form, user: @user)
        @answer1 = create(:answer, form: @form)
        @answer2 = create(:answer, form: @form)

        get "/api/v1/answers", params: { form_id: @form.id }, headers: header_with_authentication(@user)
      end

      it "returns http success 200" do
        expect_status(200)
      end

      it "returns form list with 2 answer" do
        expect(json.count).to eql(2)
      end

      it "returned answer have right datas" do
        expect(json[0]).to eql(JSON.parse(@answer1.to_json))
        expect(json[1]).to eql(JSON.parse(@answer2.to_json))
      end
    end
  end
end
