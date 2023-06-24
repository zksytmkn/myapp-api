require "rails_helper"

RSpec.describe "user_mailer/change_email_error_invalid" do
  context "in html format" do
    before do
      render template: "user_mailer/change_email_error_invalid.html.erb"
    end

    it "renders the error message" do
      expect(rendered).to match "こちらのリンクは有効ではありません。"
    end
  end
end
