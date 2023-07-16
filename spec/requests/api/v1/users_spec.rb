require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  let(:valid_attributes) do 
    password = "#{SecureRandom.alphanumeric(8)}!@"
    {
      name: "User#{SecureRandom.hex(3)}", # ユニークな名前を生成
      email: "test#{SecureRandom.hex(5)}@example.com", # ユニークなメールアドレスを生成
      password: password,
      password_confirmation: password
    }
  end

  before do
    allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get api_v1_users_path, headers: headers
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
      get api_v1_user_path(user), headers: headers
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:success)
    end

    it "returns the requested user" do
      expect(json['id']).to eq(user.id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new user" do 
        expect {
          post api_v1_users_path, params: valid_attributes, headers: headers
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created), "Unexpected response: #{response.body}"
      end
    end
  
    context "with invalid parameters" do
      before do
        post api_v1_users_path, params: { user: { name: nil } }, headers: headers
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
        put api_v1_user_path(user), params: new_attributes, headers: headers
      end

      it "updates the requested user" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      before do
        put api_v1_user_path(user), params: { name: nil }, headers: headers
      end

      it "does not update the user" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete api_v1_user_path(user), headers: headers
    end
  
    it "destroys the requested user" do
      expect(response).to have_http_status(:no_content)
      expect(User.exists?(user.id)).to be false
    end
  end
end