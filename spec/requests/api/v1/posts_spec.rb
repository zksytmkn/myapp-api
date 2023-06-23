require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  before do
    allow_any_instance_of(Api::V1::PostsController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before do
      get "/api/v1/posts"
    end

    it "returns a list of posts" do
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "GET /show" do
    before do
      get "/api/v1/posts/#{post.id}"
    end

    it "returns a post" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      before do
        post "/api/v1/posts", params: { title: "Title", body: "Body", image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'image.jpg')) }
      end

      it "creates a new post" do
        expect(response).to have_http_status(:created)
        expect(Post.count).to eq(2)
      end
    end

    context "with invalid parameters" do
      before do
        post "/api/v1/posts", params: { title: "", body: "", image: nil }
      end

      it "does not create a new post" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Post.count).to eq(1)
      end
    end
  end

  describe "PUT /update" do
    context "with valid parameters" do
      before do
        put "/api/v1/posts/#{post.id}", params: { title: "Updated Title", body: "Updated Body", image: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'image.jpg')) }
      end

      it "updates the post" do
        expect(response).to have_http_status(:success)
        expect(post.reload.title).to eq("Updated Title")
      end
    end

    context "with invalid parameters" do
      before do
        put "/api/v1/posts/#{post.id}", params: { title: "", body: "", image: nil }
      end

      it "does not update the post" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/posts/#{post.id}"
    end

    it "deletes the post" do
      expect(response).to have_http_status(:no_content)
      expect(Post.count).to eq(0)
    end
  end
end
