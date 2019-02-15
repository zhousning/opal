ActiveAdmin.register User  do

  permit_params  :phone, :password, :password_confirmation, :name, :identity, :alipay, :status

  actions :all, :except => [:destroy]

  menu label: "用户管理", :priority => 3 
  config.per_page = 20
  config.sort_order = "id_asc"

  index :title=>"用户管理" do
    selectable_column
    id_column
    
    column Setting.users.phone, :phone
    column Setting.users.name, :name
    column Setting.users.identity, :identity
    column Setting.users.alipay, :alipay
    column Setting.users.status, :status

    column "创建时间", :created_at, :sortable=>:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间", :updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  
  filter :phone, :label => Setting.users.phone
  filter :password, :label => Setting.users.password
  filter :password_confirmation, :label => Setting.users.password_confirmation
  filter :name, :label => Setting.users.name
  filter :identity, :label => Setting.users.identity
  filter :alipay, :label => Setting.users.alipay
  filter :status, :label => Setting.users.status
  filter :created_at

  form do |f|
    f.inputs "详情" do
      
      f.input :phone, :label => Setting.users.phone 
      f.input :password, :label => Setting.users.password 
      f.input :password_confirmation, :label => Setting.users.password_confirmation 
      f.input :name, :label => Setting.users.name 
      f.input :identity, :label => Setting.users.identity 
      f.input :alipay, :label => Setting.users.alipay 
      f.input :status, :label => Setting.users.status 
    end
    f.actions
  end

  show :title=>'用户管理' do
    attributes_table do
      row "ID" do
        user.id
      end
      
      row Setting.users.phone do
        user.phone
      end
      row Setting.users.password do
        user.password
      end
      row Setting.users.password_confirmation do
        user.password_confirmation
      end
      row Setting.users.name do
        user.name
      end
      row Setting.users.identity do
        user.identity
      end
      row Setting.users.alipay do
        user.alipay
      end
      row Setting.users.status do
        user.status
      end

      row "创建时间" do
        nn
        user.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        user.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

  member_action :pass do
    user = User.find(params[:id])
    user.pass
    user.tree.add_count(1) if user.tree.count == 0 
    user.leaf.enable
    user.citrine.add_count(Setting.awards.one_citrine)
    unless user.inviter.blank?
      higher_up = User.find_by_number(user.inviter)
      if higher_up
        higher_up.citrine.add_count(Setting.awards.ten_citrine)
        higher(higher_up)
      end
    end
    redirect_to :action => :index
  end

  member_action :reject do
    user = User.find(params[:id])
    user.reject
    user.leaf.disable
    redirect_to :action => :index
  end

  def higher(user)
    unless user.inviter.blank?
      higher_up = User.find_by_number(user.inviter)
      if higher_up
        higher_up.citrine.add_count(Setting.awards.one_citrine)
        higher(higher_up)
      end
    end
  end

def nn
  "ddd"
end
end

