require "validator/email_validator"

class User < ApplicationRecord
  include TokenGenerateService
  include ActionView::Helpers::UrlHelper

  before_validation :downcase_email
  before_create :set_email_confirmation

  has_secure_password
  has_one_attached :image
  has_many :products, dependent: :destroy
  has_many :product_comments, dependent: :destroy
  has_many :product_favorites, dependent: :destroy
  has_many :product_unfavorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_unfavorites, dependent: :destroy
  has_many :communities, dependent: :destroy
  has_many :community_messages, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :inviting_invitations, class_name: 'Invitation', :foreign_key => 'inviting_id'
  has_many :invited_invitations, class_name: 'Invitation', :foreign_key => 'invited_id'
  has_many :following_relationships, class_name: 'Relationship', :foreign_key => 'following_id'
  has_many :followed_relationships, class_name: 'Relationship', :foreign_key => 'followed_id'
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_details, dependent: :destroy

  validates :name, presence: true, length: { maximum: 13, allow_blank: true }, uniqueness: { case_sensitive: false }

  validates :email, presence: true, email: { allow_blank: true }, uniqueness: { case_sensitive: false }

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z0-9])(?=.*[!@#$%^&*+\-_])(?=.*[\S])/x
  validates :password,  presence: true,
                        length: { minimum: 8, allow_blank: true },
                        format: { with: VALID_PASSWORD_REGEX, message: "パスワードは英数字と記号を含む必要があります", allow_blank: true },
                        allow_nil: true

  enum confirmation_status: {
    confirmed: 0,
    unconfirmed: 1,
  }

  def to_json(options = {})
    if options[:index] || options[:show]
      {
        id: self.id,
        name: self.name,
        prefecture: self.prefecture,
        profile_text: self.profile_text
      }
    else
      super
    end
  end

  def set_email_confirmation
    self.confirmation_token = SecureRandom.urlsafe_base64(47)
    self.expiration_date = Time.zone.now + Constants::EMAIL_CONFIRMATION_LIMIT
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
    as_json(only: [:id, :name, :email, :prefecture, :zipcode, :street, :building, :profile_text, :image_url]).merge(payload).with_indifferent_access
  end

  def downcase_email
    self.email.downcase! if email
  end

  def reset_password_expired?
    reset_password_expires_at < Time.zone.now
  end
end