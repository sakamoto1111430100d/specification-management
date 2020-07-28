class CreateIndividuals < ActiveRecord::Migration[5.0]
  def change
    create_table :individuals do |t|
      t.string :email, null: false
      t.string :company
      t.string :office
      t.string :department
      t.string :name, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
