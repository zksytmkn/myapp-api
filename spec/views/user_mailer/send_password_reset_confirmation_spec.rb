require "rails_helper"

RSpec.describe "user_mailer/send_password_reset_confirmation" do
  let(:user) { create(:user) }

  before do
    assign(:user, user)
  end

  context "in html format" do
    before do
      render template: "user_mailer/send_password_reset_confirmation.html.erb"
    end

    it "renders the user name" do
      expect(rendered).to match CGI.escapeHTML(user.name)
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "パスワードが変更されました。"
    end
  end

  context "in text format" do
    before do
      render template: "user_mailer/send_password_reset_confirmation.text.erb"
    end

    it "renders the user name" do
      expect(rendered).to match user.name
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "パスワードが変更されました。"
    end
  end
end
