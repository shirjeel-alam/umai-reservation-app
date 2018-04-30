class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.string :name
      t.integer :start_at
      t.integer :end_at
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
