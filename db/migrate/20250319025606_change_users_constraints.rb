class ChangeUsersConstraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name, true
    change_column_null :users, :password_digest, true
  end
end
