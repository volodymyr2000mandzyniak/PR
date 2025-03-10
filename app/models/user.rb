class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :projects, dependent: :destroy

  validates :password, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true

  before_validation :generate_jti, on: :create

  private

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end
end