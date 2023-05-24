class Api::V1::ContactsController < ApplicationController

  def create
    begin
      UserMailer.send_contact_email(contact_params[:name], contact_params[:email], contact_params[:content]).deliver_now
      render json: { message: 'お問い合わせありがとうございます。担当者よりご連絡いたします。' }, status: :ok
    rescue => e
      Rails.logger.error "メール送信失敗: #{e.message}"
      render json: { error: 'お問い合わせの送信に失敗しました。もう一度お試しください。' }, status: :internal_server_error
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
