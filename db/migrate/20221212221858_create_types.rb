class CreateTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :types, id: :uuid do |t|
      t.string :name
      t.boolean :subtype, default: false
      t.timestamps
    end
  end
end
