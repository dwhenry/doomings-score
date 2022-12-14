class CreateCardTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_types, id: :uuid do |t|
      t.references :card, type: :uuid
      t.references :type, type: :uuid
      t.timestamps
    end
  end
end
