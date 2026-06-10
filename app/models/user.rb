class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :email, type: String
  field :password_digest, type: String

  has_secure_password

  index({ email: 1 }, { unique: true })

  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true

  def generate_auth_token
    payload = { user_id: id.to_s, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
