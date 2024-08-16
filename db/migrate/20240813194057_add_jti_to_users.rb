class AddJtiToUsers < ActiveRecord::Migration[7.1]
  def change
    # Used for JWT revocation strategy (JTI: Unique identifier for the token)
    add_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end
end
