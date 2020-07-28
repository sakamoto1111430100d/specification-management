class Individual < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  belongs_to :user
  has_many :stocks

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
end
