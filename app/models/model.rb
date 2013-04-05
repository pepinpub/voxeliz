class Model < ActiveRecord::Base
  attr_accessible :imagePath, :material, :modelPath, :name, :price, :scaleType, :user, :volume
end
