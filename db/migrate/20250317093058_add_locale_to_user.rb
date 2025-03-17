class AddLocaleToUser < ActiveRecord::Migration[8.0]
  def change
    create_enum :locale, ["en", "es"]

    add_column :users, :locale, :enum, enum_type: :locale, default: "en", null: false
  end
end
