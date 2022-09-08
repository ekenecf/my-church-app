class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  has_many :members, foreign_key: 'user_id'
  has_many :groups, foreign_key: 'group_id'
  has_many :events, foreign_key: 'event_id'

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
