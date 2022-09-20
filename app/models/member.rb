class Member < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :groups, through: :group_members
  has_many :group_members, foreign_key: 'member_id', dependent: :destroy

  mount_uploader :picture, ImageUploader

  validates :name, presence: true
  validates :phone_number, presence: true, length: { minimum: 0, maximum: 11 }
  validates :occupation, presence: true
  validates :picture, presence: true
  validates :post_held, presence: true
  validates :birthday, presence: true
end
