class Company < ApplicationRecord
  has_many :documents
  has_many :documents, foreign_key: 'company_id'
  has_many :users, through: :documents

  validates :name, presence: true

  def self.search(keyword)
    return Company.all unless search
    Company.where("name LIKE ?", "%#{keyword}%")
  end
end
