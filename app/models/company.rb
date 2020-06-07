class Company < ApplicationRecord
  has_many :items, through: :documents
  has_many :documents
end
