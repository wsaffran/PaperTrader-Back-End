class EditColumnToGames < ActiveRecord::Migration[5.2]
  def change
    change_column :games, :start_date, :date
    change_column :games, :end_date, :date
  end
end
