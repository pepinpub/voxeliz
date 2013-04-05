class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.integer :scaleType
      t.string :imagePath
      t.string :modelPath
      t.string :user
      t.decimal :price
      t.float :volume
      t.integer :material

      t.timestamps
    end
  end
end
