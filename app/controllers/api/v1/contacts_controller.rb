class Api::V1::ContactsController < ApplicationController
  def create
    UserMailer.send_contact_email(contact_params[:name], contact_params[:email], contact_params[:content]).deliver_now

    render json: { message: 'お問い合わせありがとうございます。担当者よりご連絡いたします。' }, status: :ok
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
