class ItemUser < ActiveRecord::Migration[5.0]
  def change
    drop_table :item_users
    drop_table :company_users
  end
end
