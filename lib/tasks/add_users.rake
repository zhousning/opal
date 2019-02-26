require 'yaml'
require 'logger'

namespace 'db' do
  desc "init user"
  task(:add_users => :environment) do
    init 
  end
end

def init
  users = YAML.load_file("lib/tasks/user.yaml")
  user_hash = Hash.new
  
  users.each do |user|
    #@parent = User.find_by_phone('17771489340')
    p_phone = user[0].to_s
    unless user_hash[p_phone]
      @parent = User.create(:phone => p_phone, :password => "123456", :password_confirmation => "123456")
    else
      @parent = user_hash[p_phone]
    end
  
    #user_hash[p_phone] = @parent
  
    #puts p_phone
    if !user[1].nil?
      user[1].each do |c|
        c_phone = c.to_s
        unless user_hash[c_phone]
          @child = User.create(:phone => c_phone, :password => "123456", :password_confirmation => "123456", :parent_id => @parent.id, :inviter => @parent.number)
        else
          @child = user_hash[c_phone]
          @child.update(:parent => @parent)
        end
        user_hash[c_phone] = @child
      end
    end
  end
end
