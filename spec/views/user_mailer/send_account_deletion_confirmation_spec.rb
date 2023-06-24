require "rails_helper"

RSpec.describe "user_mailer/send_account_deletion_confirmation" do
  let(:user) { create(:user) }

  before do
    assign(:user, user)
    render
  end

  context "in html format" do
    it "renders the user name" do
      expect(rendered).to match CGI.escapeHTML(user.name)
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleのアカウントが正常に削除されました。"
      expect(rendered).to match "ご利用いただき、誠にありがとうございました。"
      expect(rendered).to match "今後ともEdibleをよろしくお願いいたします。"
    end
  end

  context "in text format" do
    it "renders the user name" do
      expect(rendered).to match user.name
    end

    it "renders the expected text" do
      expect(rendered).to match "Edibleのアカウントが正常に削除されました。"
      expect(rendered).to match "ご利用いただき、誠にありがとうございました。"
      expect(rendered).to match "今後ともEdibleをよろしくお願いいたします。"
    end
  end
end
