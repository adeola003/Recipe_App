class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :measurement_unit
      t.integer :price
      t.integer :quantity
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
