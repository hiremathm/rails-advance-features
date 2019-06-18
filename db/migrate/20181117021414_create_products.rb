class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :image
      t.integer :category_id
      t.integer :stock
      t.string :description
      t.boolean :cod_eligible
      t.date :release_date

      t.timestamps
    end
  end
end
