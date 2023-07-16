require 'rails_helper'

RSpec.describe "Api::V1::CommunityMessages", type: :request do
  let(:user) { create(:user) }
  let(:community) { create(:community) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::CommunityMessagesController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    let!(:community_message1) { create(:community_message, user: user, community: community, content: "Message 1") }
    let!(:community_message2) { create(:community_message, user: user, community: community, content: "Message 2") }

    before do
      get "/api/v1/communities/#{community.id}/community_messages", headers: headers
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all community messages' do
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns the correct messages' do
      messages = JSON.parse(response.body).map { |message| message['content'] }
      expect(messages).to include(community_message1.content)
      expect(messages).to include(community_message2.content)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { community_message: { content: 'Test message' } } }

    context "with valid attributes" do
      before do
        post "/api/v1/communities/#{community.id}/community_messages", params: valid_attributes, headers: headers
      end

      it 'creates a new community message' do
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['content']).to eq('Test message')
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { { community_message: { content: '' } } }
    
      it 'does not create a new community message' do
        expect {
          post "/api/v1/communities/#{community.id}/community_messages", params: invalid_attributes, headers: headers
        }.to_not change(CommunityMessage, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include('メッセージを入力してください')
      end
    end
  end
end
