class User < ApplicationRecord
  @@nanoid_alphabet = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

  extend FriendlyId
  friendly_id :nickname, use: [:slugged, :finders]
  
  devise :database_authenticatable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  validates_presence_of     :email 
  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: password_length, allow_blank: true

  before_validation :set_nickname
  before_update :prevent_update_if_nickname_exists

  has_many :articles, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.nickname
    end
  end

  private
  def set_nickname
    return if self.persisted?

    self.nickname = self.email.split('@').first
    while nickname_exists?
      self.nickname = "#{self.nickname}_#{Nanoid.generate(size: 6, alphabet: @@nanoid_alphabet)}"
    end
  end

  def should_generate_new_friendly_id?
    nickname.blank? || self.nickname_changed?
  end

  def nickname_exists?
    User.where(nickname: self.nickname).first.present?
  end

  def prevent_update_if_nickname_exists
    if nickname_exists?
      errors.add :nickname, 'This nickname is already being used. Choose something else.'
      throw :abort
    end
  end
end
