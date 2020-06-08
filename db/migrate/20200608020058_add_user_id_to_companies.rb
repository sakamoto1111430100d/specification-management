class AddUserIdToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :user_id, :integer, null: false
  end
end
