class CreateSpetifications < ActiveRecord::Migration[5.0]
  def change
    create_table :spetifications do |t|
      t.string :date, null: false
      t.string :image
      t.references :company, foreign_key: true
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
