class User < ActiveRecord::Base
  validates :password_digest, presence: true
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6}, allow_nil: true

  after_initialize :ensure_session_token

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat

  has_many :cat_rental_requests

  attr_reader :password

  def self.find_by_credentials(user_name, password)
    possible_user = User.find_by_user_name(user_name)

    if !possible_user
      return nil
    elsif possible_user.is_password?(password)
      possible_user
    else
      return nil
    end

  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def is_password?(password)
    b_obj = BCrypt::Password.new(self.password_digest)
    b_obj.is_password?(password)
  end
end
