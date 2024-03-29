require "rails_helper"

RSpec.describe "users/activate_account_error_invalid" do
  context "in html format" do
    before do
      render template: "users/activate_account_error_invalid"
    end

    it "renders the error message" do
      expect(rendered).to match "こちらのリンクは有効ではありません。"
    end
  end
end
