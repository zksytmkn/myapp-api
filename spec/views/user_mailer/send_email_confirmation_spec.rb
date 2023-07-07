require "rails_helper"

RSpec.describe "user_mailer/send_email_confirmation" do
  let(:user) { create(:user, confirmation_token: "123456") }

  before do
    assign(:user, user)
  end

  context "in html format" do
    before do
      render template: "user_mailer/send_email_confirmation", formats: [:html]
    end

    it "renders the user name" do
      expect(rendered).to match CGI.escapeHTML(user.name)
    end

    it "renders the confirmation token" do
      expect(rendered).to include user.confirmation_token
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "下記のリンクをクリックして、アカウントを有効化してください。"
      expect(rendered).to match "＊このURLの有効期限は24時間です。"
    end
  end

  context "in text format" do
    before do
      render template: "user_mailer/send_email_confirmation", formats: [:text]
    end

    it "renders the user name" do
      expect(rendered).to match user.name
    end

    it "renders the confirmation token" do
      expect(rendered).to include user.confirmation_token
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleをご利用いただきありがとうございます。"
      expect(rendered).to match "下記のリンクをクリックして、アカウントを有効化してください。"
      expect(rendered).to match "＊このURLの有効期限は24時間です。"
    end
  end
end
