class UpdateDateColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :transaction_date, :datetime
  end
end
