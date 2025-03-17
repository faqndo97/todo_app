class AddPositionToItem < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :position, :integer, null: false
  end
end
