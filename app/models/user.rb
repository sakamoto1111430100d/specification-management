class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :company_users
  has_many :companies, through: :company_users
  has_many :item_users
  has_many :items, through: :item_users
  has_many :documents

end
