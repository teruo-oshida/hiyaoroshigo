class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :drinking, foreign_key: true
      t.integer :score, null: false

      t.timestamps
    end
  end
end
