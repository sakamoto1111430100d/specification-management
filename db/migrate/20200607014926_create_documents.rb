class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.integer :date, null: false
      t.string :author, null: false
      t.string :image
      t.references :company, foreign_key: true
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
