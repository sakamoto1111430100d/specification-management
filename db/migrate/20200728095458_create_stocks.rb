class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.references :document, foreign_key: true
      t.references :individual, foreign_key: true
      t.timestamps
    end
  end
end
