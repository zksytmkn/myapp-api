require 'rails_helper'

RSpec.describe "RefreshTokens", type: :request do
  describe "GET /refresh_tokens" do
    it "works! (now write some real specs)" do
      get refresh_tokens_path
      expect(response).to have_http_status(200)
    end
  end
end
