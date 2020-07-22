class Item < ApplicationRecord
  has_many :documents
  has_many :documents, foreign_key: 'item_id'
  has_many :users, through: :documents

  validates :name, presence: true
  validates :code, presence: true
end
