class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :time
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps null: false
    end
  end
end
