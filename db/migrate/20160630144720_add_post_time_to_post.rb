class AddPostTimeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string
    add_column :posts, :post_time, :datetime
  end
end
