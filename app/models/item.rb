class Item < ApplicationRecord
  has_many :companies, through: :documents
  has_many :documents
end
