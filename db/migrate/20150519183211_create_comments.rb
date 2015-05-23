class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :message
      t.integer :user_id
      t.integer :ticket_id

      t.timestamps null: false
    end
  end
end
