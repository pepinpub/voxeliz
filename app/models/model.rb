class Model < ActiveRecord::Base


  # has_one :user
  belongs_to :user

  attr_accessible :area, :bbX, :bbY, :bbZ, :ext, :imagePath, :material, :modelPath, :name, :price, :scale, :scaleType, :volume, :user_id


  attr_accessible :avatar
  #Dans la ligne suivante :user_id est accessible cas nous l avons declare dans l initializers Paperclip!!
  has_attached_file   :avatar, 
					  # :path => 'images/:attachment/:id_:style_:basename.:extension',
            :path => "3dmodels/users/:user_id/:style_:basename.:extension",
					  :url => ':s3_domain_url',
					  :bucket => ENV['AWS_BUCKET'],
					  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
					  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
					  :s3_permissions => {
					      #:small => :public_read,
					      #:original => :private
					    }
					  # :styles => { :small => "150x150>" }
  #:styles => {:thumb => {:geometry => '75x75>', :format => :jpg},
  #:original => {:geometry => '180x180>', :format => :jpg},
  #:path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension",
  #:default_url => '/images/missing_:style.jpg'

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 100.megabytes

  # after_post_process :get_volume_value
  def get_volume_value
     animal = self.avatar.url 
     @output = `mayapy test4.py #{animal}`
     # if !@output.nil?
     if @output.length > 6
       words = @output.split(' ')
       #bbX
       tmpF = Float(words[0])
       self.bbX = tmpF.round(3)
       #bbY
       tmpF = Float(words[1])
       self.bbY = tmpF.round(3)
       #bbZ
       tmpF = Float(words[2])
       self.bbZ = tmpF.round(3)

       # # @model.name= output
       self.name =@output
       self.save!
       # self.update_attribute(:name, @output)
      else
        self.name ="Error"
        # flash[:notice] = "You have successfully logged out"
        # redirect_to root_url
      end
  end










  # before_create :owner
  # def owner
  #     self.user_id = current_user.id
  # end


end
