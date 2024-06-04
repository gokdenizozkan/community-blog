class User < ApplicationRecord
  @@nanoid_alphabet = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of     :email 
  validates_presence_of     :password, if: :password_required? # recommended
  validates_confirmation_of :password, if: :password_required? # recommended
  validates_length_of       :password, within: password_length, allow_blank: true # recommended

  before_create :set_nickname

  has_many :articles
  has_many :votes
  has_many :comments

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
end
