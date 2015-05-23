class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :category
      t.integer :user_id
      t.string :description
      t.string :status
      t.datetime :ticket_date

      t.timestamps null: false
    end
  end
end
