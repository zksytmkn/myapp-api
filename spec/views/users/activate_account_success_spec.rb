require "rails_helper"

RSpec.describe "user_mailer/activate_account_success" do
  context "in html format" do
    before do
      render template: "user_mailer/activate_account_success.html.erb"
    end

    it "renders the success message" do
      expect(rendered).to match "アカウントが有効化されました。"
    end
  end
end
