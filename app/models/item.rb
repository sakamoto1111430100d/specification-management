class Item < ApplicationRecord
  has_many :documents
  has_many :item_users
  has_many :users, through: :item_users
end
