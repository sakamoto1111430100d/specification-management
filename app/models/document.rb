class Document < ApplicationRecord
  belongs_to :company
  belongs_to :item
end
