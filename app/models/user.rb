class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :jwt_authenticatable, jwt_revocation_strategy: self
  
  has_many :projects, dependent: :destroy

  before_validation :generate_jti, on: :create

  private

  def generate_jti
    self.jti ||= SecureRandom.uuid
  end
end
