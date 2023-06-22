require 'rails_helper'

RSpec.describe 'Api::V1::PostComments', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:post_comment) { create(:post_comment, user: user, post: post) }

  describe 'GET /index' do
    before do
      get "/api/v1/posts/#{post.id}/post_comments"
    end

    it 'returns the list of comments' do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post "/api/v1/posts/#{post.id}/post_comments", params: { post_comment: { content: 'New comment' } }
      end

      it 'creates a new comment' do
        expect(response).to have_http_status(:created)
        expect(PostComment.count).to eq(2)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/v1/posts/#{post.id}/post_comments", params: { post_comment: { content: '' } }
      end

      it 'does not create a new comment' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(PostComment.count).to eq(1)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      delete "/api/v1/posts/#{post.id}/post_comments/#{post_comment.id}"
    end

    it 'deletes the comment' do
      expect(response).to have_http_status(:no_content)
      expect(PostComment.count).to eq(0)
    end
  end
end
