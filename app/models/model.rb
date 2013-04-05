class Model < ActiveRecord::Base
  attr_accessible :area, :bbX, :bbY, :bbZ, :ext, :imagePath, :material, :modelPath, :name, :price, :scale, :scaleType, :volume
end
