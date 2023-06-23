require 'rails_helper'

RSpec.describe "Api::V1::Relationships", type: :request do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let!(:relationship) { create(:relationship, following: user, followed: followed_user) }

  before do
    allow_any_instance_of(Api::V1::RelationshipsController).to receive(:current_user).and_return(user)
  end

  describe "POST /create" do
    let(:valid_attributes) { { followed_id: followed_user.id } }
    let(:invalid_attributes) { { followed_id: nil } }

    context "with valid parameters" do
      before do
        post "/api/v1/relationships", params: { relationship: valid_attributes }
      end

      it "creates a new relationship" do
        expect(response).to have_http_status(:created)
        expect(Relationship.count).to eq(2)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/relationships", params: { relationship: invalid_attributes }
      end

      it "does not create a new relationship" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Relationship.count).to eq(1)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/relationships", params: { relationship: { followed_id: followed_user.id } }
    end

    it "deletes the relationship" do
      expect(response).to have_http_status(:no_content)
      expect(Relationship.count).to eq(0)
    end
  end

  describe "GET /user_follow_relationships/:id" do
    before do
      get "/api/v1/user_follow_relationships/#{user.id}"
    end

    it "returns the user's followers and followings" do
      expect(response).to have_http_status(:success)
      response_body = JSON.parse(response.body)
      expect(response_body['following'].length).to eq(1)
      expect(response_body['followers'].length).to eq(0)
    end
  end
end
