class AddAttachmentAvatarToModels < ActiveRecord::Migration
  def self.up
    change_table :models do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :models, :avatar
  end
end
