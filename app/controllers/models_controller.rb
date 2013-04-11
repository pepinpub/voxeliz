class ModelsController < ApplicationController
  # GET /models
  # GET /models.json
  def index
    # @models = Model.all
    # @models =   Model.find(:all, :conditions => [ "user_id = ?", user_id])
     @user = User.find(current_user.id)
     @models = @user.models

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @models }
    end
  end

  # GET /models/1
  # GET /models/1.json
  def show

    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @model }
    end
  end

  # GET /models/new
  # GET /models/new.json
  def new
    @model = Model.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @model }
    end
  end

  # GET /models/1/edit
  def edit
    @model = Model.find(params[:id])
  end


# def objSize
#       #output = `mayapy test3.py https://s3-eu-west-1.amazonaws.com/vox3/images/avatars/26_original_pitcher.obj`
#       # animal = "https://s3-eu-west-1.amazonaws.com/vox3/images/avatars/26_original_pitcher.obj"
#       # animal =  "http://vox3.s3.amazonaws.com/3dmodels/users/2/original_sphere.obj"
      
#       animal = @model.avatar.url 
#       #a = animal.split("?")
#       #tutu = a[0]
#       # output = `mayapy test3.py http://vox3.s3.amazonaws.com/3dmodels/users/2/original_sphere.obj`
#        output = `mayapy test3.py #{animal}`
#       #return output
#       toto=1
#       # require 'net/ssh'
#       # Net::SSH.start("ec2-54-242-219-53.compute-1.amazonaws.com", "public") do |ssh|
#         #animal = @model.avatar.url 
#         #result = ssh.exec!("mayapy c:/test3b.py #{animal}")
#         #toto= result
#       #end
#       return output
#   end

def get_volume_value
   animal = @model.avatar.url 

   #Calcule en local
   @output = `mayapy test4.py #{animal}`

   #Calcule sur EC2
   # require 'net/ssh'
   # Net::SSH.start("ec2-54-242-219-53.compute-1.amazonaws.com", "public") do |ssh|
   #    @output = ssh.exec!("mayapy c:/test3b.py #{animal}")
   #  end
    
   # if !@output.nil?
   if @output.length > 6
     words = @output.split(' ')
     #bbX
     tmpF = Float(words[0])
     @model.bbX = tmpF.round(3)
     #bbY
     tmpF = Float(words[1])
     @model.bbY = tmpF.round(3)
     #bbZ
     tmpF = Float(words[2])
     @model.bbZ = tmpF.round(3)

     # # @model.name= output
     @model.name =@output
     @model.save!
     # self.update_attribute(:name, @output)
    else
      @model.name ="Error"
      @model.save!
      # flash[:notice] = "You have successfully logged out"
      # redirect_to root_url
    end
  end



  # POST /models
  # POST /models.json
  def create
    # @post.user = current_user
    # @user = User.find(params[:user_id])
    # @model = @user.models.create(params[:model])

    # On construit le model pour l utilsateur courant
    @model = current_user.models.build(params[:model])
    #Equivault a ces deux lignes
    # @model = Model.new(params[:model])
    # @model.user = current_user

    #On appelle la procedure objSize
    # @model.name= objSize
    # @model.name = "test"

    @model.scale = 1
    @model.modelPath = @model.avatar.url
    @model.bbX=100
    @model.bbY=100
    @model.bbZ=100

    respond_to do |format|

      if @model.save
        get_volume_value
        format.html { redirect_to @model, notice: 'Model was successfully created.' }
        format.json { render json: @model, status: :created, location: @model }

      else
        format.html { render action: "new" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.json
  def update
    @model = Model.find(params[:id])
    # @model.name = "test"
    @model.scale = 1
    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to @model, notice: 'Model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.json
  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to models_url }
      format.json { head :no_content }
    end
  end
end
