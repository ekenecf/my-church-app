class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  has_many :members, foreign_key: 'user_id'

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
