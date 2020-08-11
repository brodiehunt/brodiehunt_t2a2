class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.float :price
      t.references :brand, null: false, foreign_key: true
      t.references :style, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :postcode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
