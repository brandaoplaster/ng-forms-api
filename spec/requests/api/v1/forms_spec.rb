require "rails_helper"

RSpec.describe "Api::V1::Forms", type: :request do
  describe "GET /index" do
    context "with invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :get, "/api/v1/forms"
    end

    context "with valid authentication headers" do
      before do
        @user = create(:user)
        @form1 = create(:form, user: @user)
        @form2 = create(:form, user: @user)

        get "/api/v1/forms", params: {}, headers: header_with_authentication(@user)
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
    before do
      @user = create(:user)
    end

    context "when form exists" do
      context "and is enable" do
        before do
          @form = create(:form, user: @user, enable: true)
        end

        it "returns http success 200" do
          expect_status(200)
        end

        it "returned form with right datas" do
          get "/api/forms/#{@form.friendly_id}", params: {}, headers: header_with_authentication(@user)
          expect(json).to eql(JSON.parse(@form.to_json))
        end
      end

      context "and is unable" do
        before do
          @form = create(:form, user: @user, enable: false)
        end

        it "returns http not found 404" do
          get "/api/v1/forms/#{FFaker::Lorem.word}", params: { id: @form.friendly_id }, headers: header_with_authentication(@user)
          expect_status(404)
        end
      end
    end

    context "when form dont exists" do
      it "returns http not found 404" do
        get "/api/v1/forms/#{FFaker::Lorem.word}", params: {}, headers: header_with_authentication(@user)
        expect_status(404)
      end
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/forms/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :post, "/api/v1/forms"
    end

    context "with valid authentication headers" do
      before do
        @user = create(:user)
      end

      context "and with valid params" do
        before do
          @form_atributes = attributes_for(:form)
          post "/api/v1/forms", params: { form: @form_atributes }, headers: header_with_authentication(@user)
        end

        it "return http success 200" do
          expect_status(200)
        end

        it "form are created with correct data" do
          @form_atributes.each do |field|
            expect(Form.first[field]).to eq(field)
          end
        end

        it "returned data is correct" do
          @form_atributes.each do |field|
            expect(json[field.first.to_s]).to eq(field.last)
          end
        end
      end

      context "and with invalid params" do
        before do
          @other_user = create(:user)
          post "/api/v1/forms", params: { form: {} }, headers: header_with_authentication(@user)
        end

        it "return http not found 404" do
          expect_status(404)
        end
      end
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/forms/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
