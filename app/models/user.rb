require "validator/email_validator"

class User < ApplicationRecord
  include TokenGenerateService

  before_validation :downcase_email
  before_create :set_email_confirmation
  after_create :send_email_confirmation

  has_secure_password
  has_one_attached :image
  has_many :products, dependent: :destroy
  has_many :productComments, dependent: :destroy
  has_many :productFavorites, dependent: :destroy
  has_many :productUnfavorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :postComments, dependent: :destroy
  has_many :postFavorites, dependent: :destroy
  has_many :postUnfavorites, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :inviting_invitations, class_name: 'Invitation', :foreign_key => 'inviting_id'
  has_many :invited_invitations, class_name: 'Invitation', :foreign_key => 'invited_id'
  has_many :following_relationships, class_name: 'Relationship', :foreign_key => 'following_id'
  has_many :followed_relationships, class_name: 'Relationship', :foreign_key => 'followed_id'

  validates :name, presence: true, length: { maximum: 30, allow_blank: true }

  validates :email,  presence: true, email: { allow_blank: true }

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates  :password, presence: true,
                        length: { minimum: 8, allow_blank: true },
                        format: { with: VALID_PASSWORD_REGEX, message: :invalid_password, allow_blank: true },
                        allow_nil: true

  enum confirmation_status: {
    confirmed: 0,
    unconfirmed: 1,
  }

  def set_email_confirmation
    self.confirmation_token = SecureRandom.urlsafe_base64(47)
    self.expiration_date = Time.zone.now + Constants::EMAIL_CONFIRMATION_LIMIT
  end

  def send_email_confirmation
    UserMailer.send_email_confirmation(self).deliver_later
  end

  def expired?
    expiration_date.present? ? expiration_date < Time.zone.now : false
  end

  def activate
    status = User.confirmation_statuses[:confirmed]
    update!(
      confirmation_status: status,
      confirmation_token: nil,
      expiration_date: nil,
    )
  end

  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end

  class << self
    def find_by_confirmed(email)
      find_by(email: email, confirmation_status: 0)
    end
  end

  def email_confirmed?
    users = User.where.not(id: id)
    users.find_by_confirmed(email).present?
  end

  def remember(jti)
    update!(refresh_jti: jti)
  end

  def forget
    update!(refresh_jti: nil)
  end

  def response_json(payload = {})
    as_json(only: [:id, :name, :email, :prefecture, :zipcode, :street, :building, :text, :image_url]).merge(payload).with_indifferent_access
  end

  private

  def downcase_email
    self.email.downcase! if email
  end
end