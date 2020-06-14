class Document < ApplicationRecord
  belongs_to :company
  belongs_to :item
  belongs_to :user

  # mount_uploader :image, ImageUploader
end
