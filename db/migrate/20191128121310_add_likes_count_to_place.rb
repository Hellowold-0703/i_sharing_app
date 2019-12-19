class AddLikesCountToPlace < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :likes_count, :integer, default: 0
  end
end
