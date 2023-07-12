RSpec.describe "Api::V1::Relationships", type: :request do
  let(:user) { create(:user) }
  let(:followed_user) { create(:user) }
  let!(:relationship) { create(:relationship, following: user, followed: followed_user) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::RelationshipsController).to receive(:current_user).and_return(user)
  end

  describe "POST /create" do
    let(:valid_attributes) { { followed_id: followed_user.id } }
    let(:invalid_attributes) { { followed_id: nil } }

    context "with valid parameters" do
      before do
        relationship.destroy!
        post "/api/v1/relationships", params: { relationship: valid_attributes }, headers: headers
      end

      it "creates a new relationship" do
        expect(response).to have_http_status(:created)
        expect(Relationship.count).to eq(1)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/relationships", params: { relationship: invalid_attributes }, headers: headers
      end

      it "does not create a new relationship" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Relationship.count).to eq(1)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/relationships/#{relationship.id}", params: { relationship: { followed_id: followed_user.id } }, headers: headers
    end
  
    it "deletes the relationship" do
      expect(response).to have_http_status(:no_content)
      expect(Relationship.count).to eq(0)
    end
  end
end  