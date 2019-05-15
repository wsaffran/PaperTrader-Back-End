class AddColumnToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :name, :string
  end
end
