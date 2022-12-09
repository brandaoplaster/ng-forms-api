require "rails_helper"

RSpec.describe "Api::V1::Forms", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/forms/index"
      expect(response).to have_http_status(:success)
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
