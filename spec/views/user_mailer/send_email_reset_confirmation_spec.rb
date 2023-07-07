require "rails_helper"

RSpec.describe "user_mailer/send_email_reset_confirmation" do
  let(:user) { create(:user) }
  let(:token) { SecureRandom.hex(10) }
  let(:email) { "new@example.com" }

  before do
    assign(:user, user)
    assign(:token, token)
    assign(:email, email)
  end

  context "in html format" do
    before do
      render template: "user_mailer/send_email_reset_confirmation", formats: [:html]
    end

    it "renders the user name" do
      expect(rendered).to match CGI.escapeHTML(user.name)
    end

    it "renders the token and email" do
      expect(rendered).to include token
      expect(rendered).to include CGI.escape(email)
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "下記のリンクをクリックして、Edibleに再度ログインしてください。"
      expect(rendered).to match "＊このURLの有効期限は24時間です。"
    end
  end

  context "in text format" do
    before do
      render template: "user_mailer/send_email_reset_confirmation", formats: [:text]
    end

    it "renders the user name" do
      expect(rendered).to match user.name
    end

    it "renders the token and email" do
      expect(rendered).to include token
      expect(rendered).to include CGI.escape(email)
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "下記のリンクをクリックして、Edibleに再度ログインしてください。"
      expect(rendered).to match "＊このURLの有効期限は24時間です。"
    end
  end
end
