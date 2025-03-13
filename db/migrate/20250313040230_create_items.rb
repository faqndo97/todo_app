class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_enum :item_status, ["pending", "complete"]

    create_table :items do |t|
      t.string :title, null: false
      t.text :description
      t.enum :status, enum_type: :item_status, default: "pending", null: false

      t.timestamps
    end
  end
end
