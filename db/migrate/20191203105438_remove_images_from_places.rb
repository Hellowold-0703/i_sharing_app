class RemoveImagesFromPlaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :places, :images, :string
  end
end
