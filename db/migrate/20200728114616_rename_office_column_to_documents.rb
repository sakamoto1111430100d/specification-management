class RenameOfficeColumnToDocuments < ActiveRecord::Migration[5.0]
  def change
    rename_column :documents, :office, :department
  end
end
