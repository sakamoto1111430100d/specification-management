class AddColumnDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :office, :string
    add_column :documents, :individual_id, :integer, foreign_key: true
  end
end
