class Stock < ApplicationRecord
  belongs_to :document
  belongs_to :individual
end
