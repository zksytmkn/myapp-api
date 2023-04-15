class Api::V1::ContactsController < ApplicationController
  def create
    UserMailer.send_contact_email(params[:name], params[:email], params[:contents]).deliver_now

    render json: { message: 'お問い合わせありがとうございます。担当者よりご連絡いたします。' }, status: :ok
  end
end
