require 'rails_helper'

RSpec.describe "AccessTokens", type: :request do
  describe "GET /access_tokens" do
    it "works! (now write some real specs)" do
      get access_tokens_path
      expect(response).to have_http_status(200)
    end
  end
end
