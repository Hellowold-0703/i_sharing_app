class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :title, null: false
      t.string :address, null: false, index: true
      t.text :description, null: false
      t.string :images, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
