require "rails_helper"

RSpec.describe "user_mailer/send_password_reset_confirmation" do
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user) }

  before do
    assign(:user, user)
  end

  context "in html format" do
    before do
      render template: "user_mailer/send_password_reset_confirmation", formats: [:html]
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
      render template: "user_mailer/send_password_reset_confirmation", formats: [:text]
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
