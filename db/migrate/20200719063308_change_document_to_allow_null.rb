class ChangeDocumentToAllowNull < ActiveRecord::Migration[5.0]
  def up
    change_column :documents, :image,:string, null: false
  end

  def down
    change_column :documents, :image,:string
  end
end
