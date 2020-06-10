class Company < ApplicationRecord
  validates :name, presence: true
  has_many :documents
  has_many :company_users
  has_many :users, through: :company_users

  
  def self.search(keyword)
    return Company.all unless search
    Company.where('name LIKE(?)', "%#{keyword}%")
  end
end
