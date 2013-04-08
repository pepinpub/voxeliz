class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :user
      t.string :name
      t.string :imagePath
      t.string :modelPath
      t.float :price
      t.float :volume
      t.integer :material
      t.string :ext
      t.float :area
      t.float :bbX
      t.float :bbY
      t.float :bbZ
      t.float :scale
      t.integer :scaleType
      
      t.timestamps
    end
     add_index :models, :user_id
  end
end
