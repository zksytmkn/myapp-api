require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  let(:user) { create(:user) }
  let!(:post_item) { create(:post, user: user) }
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  before do
    allow_any_instance_of(Api::V1::PostsController).to receive(:current_user).and_return(user)
  end

  describe "GET /show" do
    before do
      get "/api/v1/posts/#{post_item.id}", headers: headers
    end

    it "returns a post" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes) { { title: post_item.title, body: post_item.body, image: nil } }
      
      before do
        post "/api/v1/posts", params: valid_attributes, headers: headers
      end

      it "creates a new post" do
        expect(response).to have_http_status(:created)
        expect(Post.count).to eq(2)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { title: "", body: "", image: nil } }

      before do
        post "/api/v1/posts", params: invalid_attributes, headers: headers
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
        put "/api/v1/posts/#{post_item.id}", params: { title: "つぶやき更新後" }, headers: headers
      end

      it "updates the post" do
        expect(response).to have_http_status(:success)
        expect(post_item.reload.title).to eq("つぶやき更新後")
      end
    end

    context "with invalid parameters" do
      before do
        put "/api/v1/posts/#{post_item.id}", params: { title: "", body: "", image: nil }, headers: headers
      end

      it "does not update the post" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete "/api/v1/posts/#{post_item.id}", headers: headers
    end

    it "deletes the post" do
      expect(response).to have_http_status(:no_content)
      expect(Post.count).to eq(0)
    end
  end
end
