class RemoveUserIdFromCompanies < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :user_id, :integer, null: false
  end
end
