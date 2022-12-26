require "rails_helper"

RSpec.describe "Api::V1::Questions", type: :request do
  describe "POST /questions" do
    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :post, "/api/v1/questions"
    end

    context "With valid authentication headers" do
      before do
        @user = create(:user)
      end

      context "And with valid params" do
        before do
          @form = create(:form, user: @user)
          @question_attributes = attributes_for(:question)
          post "/api/v1/questions", params: {question: @question_attributes, form_id: @form.id}, headers: header_with_authentication(@user)
        end

        it "returns 200" do
          expect_status(200)
        end

        it "question are created with correct data" do
          @question_attributes.each do |field|
            expect(Question.first[field.first]).to eql(field.last)
          end
        end

        it "Returned data is correct" do
          @question_attributes.each do |field|
            expect(json[field.first.to_s]).to eql(field.last)
          end
        end
      end

      context "And with invalid params" do
        before do
          @other_user = create(:user)
        end

        context "valid form" do
          before do
            @form = create(:form, user: @user)
          end

          it "returns 400" do
            post "/api/v1/questions", params: {question: {}, form_id: @form.id}, headers: header_with_authentication(@user)
            expect_status(400)
          end
        end

        context "invalid form" do
          it "returns 400" do
            post "/api/v1/questions", params: {question: {}}, headers: header_with_authentication(@user)
            expect_status(404)
          end
        end
      end
    end
  end
end
