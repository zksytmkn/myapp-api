class Api::V1::ContactsController < ApplicationController
  def create
    name = params[:name]
    email = params[:email]
    contents = params[:contents]

    UserMailer.send_contact_email(name, email, contents).deliver_now

    render json: { message: 'お問い合わせありがとうございます。担当者よりご連絡いたします。' }, status: :ok
  end
end
