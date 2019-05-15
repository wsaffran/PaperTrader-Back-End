class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :starting_balance
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
