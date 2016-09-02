class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.references :drinker, foreign_key: true
      t.references :festival, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.string :passcode

      t.timestamps
    end
  end
end
