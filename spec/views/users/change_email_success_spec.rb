require "rails_helper"

RSpec.describe "user_mailer/change_email_success" do
  context "in html format" do
    before do
      render template: "user_mailer/change_email_success.html.erb"
    end

    it "renders the success message" do
      expect(rendered).to match "メールアドレスが変更されました。"
    end

    it "renders the instruction to logout and login again" do
      expect(rendered).to match "一旦ログアウトして、再度ログインしてください。"
    end
  end
end
