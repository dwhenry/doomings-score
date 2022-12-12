class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :favour
      t.string :effect
      t.string :colour
      t.integer :points
      t.string :collection
      t.json :effects

      t.timestamps
    end
  end
end
