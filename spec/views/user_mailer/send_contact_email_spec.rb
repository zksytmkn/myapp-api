require "rails_helper"

RSpec.describe "user_mailer/send_contact_email" do
  let(:name) { "John Doe" }
  let(:content) { "This is a test content." }

  context "in html format" do
    before do
      assign(:name, name)
      assign(:content, content)
      render template: "user_mailer/send_contact_email", formats: [:html]
    end

    it "renders the name" do
      expect(rendered).to match CGI.escapeHTML(name)
    end

    it "renders the content" do
      expect(rendered).to match CGI.escapeHTML(content)
    end

    it "renders the expected text" do
      expect(rendered).to match "お問い合わせありがとうございます。"
      expect(rendered).to match "担当者よりご連絡いたします。"
    end
  end

  context "in text format" do
    before do
      assign(:name, name)
      assign(:content, content)
      render template: "user_mailer/send_contact_email", formats: [:text]
    end

    it "renders the name" do
      expect(rendered).to match name
    end

    it "renders the content" do
      expect(rendered).to match content
    end

    it "renders the expected text" do
      expect(rendered).to match "お問い合わせありがとうございます。"
      expect(rendered).to match "担当者よりご連絡いたします。"
    end
  end
end
