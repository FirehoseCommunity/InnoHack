class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.text :body
      t.string :title
      
      t.timestamps null: false
    end
  end
end
