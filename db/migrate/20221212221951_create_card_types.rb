class CreateCardTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_types do |t|
      t.references :card
      t.references :type
      t.timestamps
    end
  end
end
