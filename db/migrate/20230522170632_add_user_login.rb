class AddUserLogin < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      add_column :users, :password_digest, :string, null: false
    end
  end
end
