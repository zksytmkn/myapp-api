require 'rails_helper'

RSpec.describe "Api::V1::Contacts", type: :request do
  let(:headers) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe "POST /create" do
    let(:valid_attributes) { { contact: { name: 'Test User', email: 'test@example.com', content: 'Test content' } } }

    context "when the email is sent successfully" do
      before do
        expect(UserMailer).to receive_message_chain(:send_contact_email, :deliver_now)
        post "/api/v1/contacts", params: valid_attributes, headers: headers
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('お問い合わせありがとうございます。担当者よりご連絡いたします。')
      end
    end

    context "when the email fails to send" do
      before do
        expect(UserMailer).to receive_message_chain(:send_contact_email, :deliver_now).and_raise('error')
        post "/api/v1/contacts", params: valid_attributes, headers: headers
      end

      it 'returns an error response' do
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['error']).to eq('お問い合わせの送信に失敗しました。もう一度お試しください。')
      end
    end

    context "when the request has invalid parameters" do
      let(:invalid_attributes) { { contact: { name: '', email: 'test@example.com', content: 'お問い合わせ内容です。' } } }

      it "returns an error response" do
        post "/api/v1/contacts", params: invalid_attributes, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('名前、メールアドレス、内容を入力してください。')
      end
    end
  end
end
