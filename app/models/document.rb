class Document < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :company
  belongs_to :item
  belongs_to :user
end
