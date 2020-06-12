class AddIndexToItems < ActiveRecord::Migration[5.0]
  def change
    add_index :items, [:name, :code]
  end
end
