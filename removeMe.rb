require 'rubygems'
require 'fog'

# create a connection
ec2 = Fog::Compute.new({
  :provider                 => 'AWS',
  :aws_access_key_id        => ENV['AWS_ACCESS_KEY_ID'],
  :aws_secret_access_key    => ENV['AWS_SECRET_ACCESS_KEY']
})

server = ec2.servers.bootstrap( image_id:'ami-424c2b2b', flavor_id:'t1.micro', private_key_path:'~/.ssh/id_rsa', public_key_path:'~/.ssh/id_rsa.pub', username:'ubuntu')
result = server.ssh('ls')
#<Fog::SSH::Result:0x007f985926cc00 @command="ls", @stderr="", @stdout="attributes.json  Toto\r\n", @status=0> 
result[0].stdout #result.at(0).stdout
server.destroy
