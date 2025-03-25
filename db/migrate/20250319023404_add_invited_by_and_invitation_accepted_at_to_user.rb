class AddInvitedByAndInvitationAcceptedAtToUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :invited_by, foreign_key: {to_table: :users}
    add_column :users, :invitation_accepted_at, :datetime
  end
end
