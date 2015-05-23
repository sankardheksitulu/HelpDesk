class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.datetime :bill_date
      t.string :pdf_url

      t.timestamps null: false
    end
  end
end
