class AddColumnDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :note, :text
  end
end
