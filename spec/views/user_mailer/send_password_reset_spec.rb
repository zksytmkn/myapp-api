require "rails_helper"

RSpec.describe "user_mailer/send_password_reset" do
  let(:user) { create(:user) }
  let(:token) { "reset_token" }

  before do
    assign(:user, user)
    assign(:token, token)
  end

  context "in html format" do
    before do
      render template: "user_mailer/send_password_reset.html.erb"
    end

    it "renders the user name" do
      expect(rendered).to match CGI.escapeHTML(user.name)
    end

    it "renders the password reset link" do
      expect(rendered).to include "http://localhost:8080/auth/reset_password_confirmation?token=#{token}"
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "以下のリンクをクリックして、パスワードを再設定してください。"
      expect(rendered).to match "このメールに心当たりがない場合、このメールを無視してください。"
    end
  end

  context "in text format" do
    before do
      render template: "user_mailer/send_password_reset.text.erb"
    end

    it "renders the user name" do
      expect(rendered).to match user.name
    end

    it "renders the password reset link" do
      expect(rendered).to include "http://localhost:8080/auth/reset_password_confirmation?token=#{token}"
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "以下のリンクをクリックして、パスワードを再設定してください。"
      expect(rendered).to match "このメールに心当たりがない場合、このメールを無視してください。"
    end
  end
end
