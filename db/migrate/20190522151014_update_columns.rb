class UpdateColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :shares, :original_shares
    add_column :transactions, :current_shares, :integer
  end
end
