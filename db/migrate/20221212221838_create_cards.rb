class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :description
      t.string :colour
      t.integer :points
      t.string :collection
      t.json :effect

      t.timestamps
    end
  end
end
