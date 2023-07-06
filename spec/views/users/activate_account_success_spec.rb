require "rails_helper"

RSpec.describe "users/activate_account_success" do
  context "in html format" do
    before do
      render template: "users/activate_account_success"
    end

    it "renders the success message" do
      expect(rendered).to match "アカウントが有効化されました。"
    end
  end
end
