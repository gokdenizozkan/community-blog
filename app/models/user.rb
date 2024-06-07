class User < ApplicationRecord
  @@nanoid_alphabet = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  extend FriendlyId
  friendly_id :nickname, use: [:slugged, :finders]
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of     :email 
  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: password_length, allow_blank: true

  before_create :set_nickname
  before_update :prevent_update_if_nickname_exists?

  has_many :articles, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  private
  def set_nickname
    self.nickname = self.email.split('@').first
    while nickname_exists?
      self.nickname = "#{self.nickname}_#{Nanoid.generate(size: 6, alphabet: @@nanoid_alphabet)}"
    end
  end

  def nickname_exists?
    User.where(nickname: self.nickname).any?
  end

  def prevent_update_if_nickname_exists?
    if nickname_exists?
      errors.add :nickname, 'This nickname is already being used. Choose something else.'
      throw :abort
    end
  end
end
