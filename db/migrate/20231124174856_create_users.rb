class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, default: '', null: false
      t.string :email, default: '', null: false
      t.string :password_digest
      t.string :auth_token
      t.jsonb :passport_data

      t.index :auth_token, unique: true

      t.timestamps
    end
  end
end
