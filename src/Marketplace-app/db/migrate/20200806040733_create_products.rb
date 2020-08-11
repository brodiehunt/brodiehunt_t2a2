class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.references :brand, null: false, foreign_key: true
      t.references :style, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
