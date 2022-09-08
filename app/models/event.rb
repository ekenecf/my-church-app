class Event < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true, length: { minimum: 0, maximum: 50 }
  validates :image, presence: true
  validates :description, presence: true
  validates :date, presence: true
end
