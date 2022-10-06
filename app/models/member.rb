class Member < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :group, class_name: 'Group', foreign_key: 'group_id'

  validates :name, presence: true
  validates :phone_number, presence: true, length: { minimum: 0, maximum: 11 }
  validates :occupation, presence: true
  validates :picture, presence: true
  validates :post_held, presence: true
  validates :birthday, presence: true
end
