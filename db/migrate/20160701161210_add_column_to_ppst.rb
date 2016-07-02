class AddColumnToPpst < ActiveRecord::Migration
  def change
    add_column :posts, :api_type, :string
    remove_column :posts, :type, :string
  end
end
