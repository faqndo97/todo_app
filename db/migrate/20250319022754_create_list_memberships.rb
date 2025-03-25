class CreateListMemberships < ActiveRecord::Migration[8.0]
  def change
    create_enum :list_membership_role, %w[admin participant]

    create_table :list_memberships do |t|
      t.references :list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.enum :role, enum_type: :list_membership_role, default: "participant", null: false

      t.timestamps
    end
  end
end
