require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:token) { "sample_token" }
  let(:email) { "test@example.com" }
  let(:name) { "Test User" }
  let(:content) { "This is a test content" }

  describe '#send_email_confirmation' do
    let(:mail) { UserMailer.send_email_confirmation(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Edible】メールアドレス確認のお願い')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['edible010126@gmail.com'])
    end
  end

  describe '#send_email_reset_confirmation' do
    let(:mail) { UserMailer.send_email_reset_confirmation(user, email, token) }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Edible】メールアドレス変更のご連絡')
      expect(mail.to).to eq([email])
      expect(mail.from).to eq(['edible010126@gmail.com'])
    end
  end

  describe '#send_password_reset_confirmation' do
    let(:mail) { UserMailer.send_password_reset_confirmation(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Edible】パスワード変更のご連絡')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['edible010126@gmail.com'])
    end
  end

  describe '#send_password_reset' do
    let(:mail) { UserMailer.send_password_reset(user, token) }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Edible】パスワード再設定のご案内')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['edible010126@gmail.com'])
    end
  end

  describe '#send_contact_email' do
    let(:mail) { UserMailer.send_contact_email(name, email, content) }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Edible】お問い合わせありがとうございます')
      expect(mail.to).to eq([email])
      expect(mail.from).to eq(['edible010126@gmail.com'])
    end
  end

  describe '#send_account_deletion_confirmation' do
    let(:mail) { UserMailer.send_account_deletion_confirmation(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('【Edible】アカウント削除のご連絡')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['edible010126@gmail.com'])
    end
  end
end
