class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :members, foreign_key: 'user_id'

  validates :name, presence: true, length: { minimum: 0, maximum: 36 }
  validates :detail, presence: true
end
