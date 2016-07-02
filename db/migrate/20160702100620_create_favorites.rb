class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :user_id, null: false
      t.integer :post_id, null: false
      t.timestamps null: false
    end
  end
end
