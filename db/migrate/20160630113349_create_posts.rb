class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :text
      t.string :image
      t.string :api_type
      t.datetime :post_time
      t.string :key
      t.timestamps null: false
    end
  end
end
