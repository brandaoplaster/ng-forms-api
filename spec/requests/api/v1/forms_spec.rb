require "rails_helper"

RSpec.describe "Api::V1::Forms", type: :request do
  describe "GET /index" do
    context "with invalid authencation headers" do
      it_behaves_like :deny_without_authorization, :get, "/api/v1/forms"
    end

    context "with valid authentication headers" do
      before do
        @user = create(:user)
        @form1 = create(:form, user: @user)
        @form2 = create(:form, user: @user)

        get "api/v1/forms", params: {}, headers: header_with_authentication(@user)
      end

      it "returns http success 200" do
        expect_status(200)
      end

      it "returns form list with 2 forms" do
        expect(json.count).to eql(2)
      end

      it "returned forms have right datas" do
        expect(json[0]).to eql(JSON.parse(@form1.to_json))
        expect(json[1]).to eql(JSON.parse(@form2.to_json))
      end
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/forms/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/forms/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/forms/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/forms/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
