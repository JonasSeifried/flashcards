class DropSessionsTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :sessions
  end

  def down
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :user_agent
      t.string :ip_address
      t.timestamps
    end
  end
end
