class Event < ApplicationRecord
  # mount_uploader :image, ImageUploader
  # mount_uploader :image1, ImageUploader
  # mount_uploader :image2, ImageUploader
  # mount_uploader :image3, ImageUploader
  # mount_uploader :image4, ImageUploader
  # mount_uploader :image5, ImageUploader

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true, length: { minimum: 0, maximum: 30 }
  validates :image, presence: true
  validates :image1, presence: true
  validates :description, presence: true
  validates :date, presence: true
end
