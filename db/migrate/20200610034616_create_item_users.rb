class CreateItemUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :item_users do |t|
      t.references :user, index: true
      t.references :company, index: true
      t.timestamps
    end
  end
end
