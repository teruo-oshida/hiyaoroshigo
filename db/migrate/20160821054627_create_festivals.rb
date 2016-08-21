class CreateFestivals < ActiveRecord::Migration[5.0]
  def change
    create_table :festivals do |t|
      t.string :name, null: false
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
