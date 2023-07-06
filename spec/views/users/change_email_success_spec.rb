require "rails_helper"

RSpec.describe "users/change_email_success" do
  context "in html format" do
    before do
      render template: "users/change_email_success"
    end

    it "renders the success message" do
      expect(rendered).to match "メールアドレスが変更されました。"
    end

    it "renders the instruction to logout and login again" do
      expect(rendered).to match "一旦ログアウトして、再度ログインしてください。"
    end
  end
end
