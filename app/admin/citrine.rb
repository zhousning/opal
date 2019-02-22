ActiveAdmin.register Citrine  do

  permit_params  :count, :total

  actions :all, :except => [:new, :destroy]

  menu label: "茶晶管理", :priority => 10 
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :count, :label => Setting.citrines.count
  filter :total, :label => Setting.citrines.total
  filter :user, :label => Setting.users.phone
  filter :created_at

  index :title=>"todo" do
    selectable_column
    id_column
    
    column Setting.users.name, :name do |f|
      f.user.name
    end
    column Setting.users.phone, :phone do |f|
      f.user.phone
    end
    column Setting.citrines.count, :count
    column Setting.citrines.total, :total

    column "创建时间", :created_at, :sortable=>:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间", :updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  form do |f|
    f.inputs "详情" do
      
      f.input :count, :label => Setting.citrines.count 
      f.input :total, :label => Setting.citrines.total 
    end
    f.actions
  end

  show :title=>'茶晶管理' do
    attributes_table do
      row "ID" do
        citrine.id
      end
      
      row Setting.citrines.count do
        citrine.count
      end
      row Setting.citrines.total do
        citrine.total
      end

      row "创建时间" do
        citrine.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        citrine.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

end
