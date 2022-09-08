class Group < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :members, through: :group_members
  has_many :group_members, foreign_key: 'group_id', dependent: :destroy

  validates :name, presence: true, length: { minimum: 0, maximum: 36 }
  validates :detail, presence: true
end
