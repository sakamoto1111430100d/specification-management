class Document < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :company
  belongs_to :item
  belongs_to :user
  validates :date, presence: true, length: { is: 8}
  validates :author, presence: true
  validates :image, presence: true
end
