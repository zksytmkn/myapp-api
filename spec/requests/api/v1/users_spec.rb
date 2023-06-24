require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get api_v1_users_path
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of users" do
      expect(json).not_to be_empty
    end
  end

  describe "GET /show" do
    before do
      get api_v1_user_path(user)
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:success)
    end

    it "returns the requested user" do
      expect(json['id']).to eq(user.id)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { attributes_for(:user) }

    context "with valid parameters" do
      before do
        post api_v1_users_path, params: valid_attributes
      end

      it "creates a new user" do
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      before do
        post api_v1_users_path, params: { name: nil }
      end

      it "does not create a new user" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /update" do
    let(:new_attributes) { { name: 'New Name' } }

    context "with valid parameters" do
      before do
        put api_v1_user_path(user), params: new_attributes
      end

      it "updates the requested user" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      before do
        put api_v1_user_path(user), params: { name: nil }
      end

      it "does not update the user" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete api_v1_user_path(user)
    end

    it "destroys the requested user" do
      expect(response).to have_http_status(:ok)
    end
  end
end
