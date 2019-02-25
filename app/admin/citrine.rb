ActiveAdmin.register Citrine  do

  permit_params  :count, :total

  actions :all, :except => [:new, :destroy]

  menu label: "茶晶管理", :priority => 4 
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :user_name, :label => Setting.users.name, as: :string
  filter :user_phone, :label => Setting.users.phone, as: :string
  filter :count, :label => Setting.citrines.count
  filter :total, :label => Setting.citrines.total

  index :title=>"茶晶管理" do
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

    column "更新时间", :updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  form do |f|
    f.inputs "详情" do
      
      f.input :count, :label => Setting.citrines.count 
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

      row "更新时间" do
        citrine.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

  controller do
    def update
      @citrine = Citrine.find(params[:id])
      count = permitted_params[:citrine][:count].to_f
      current_count = @citrine.count
      total = count > current_count ? @citrine.total + (count - current_count) : @citrine.total 

      if @citrine.update(:count => count, :total => total)
        if count > current_count
          puts ">>>>>>>>."
          Consume.create(:category => Setting.consumes.category_system_citrine, :coin_cost => (count - current_count), :status => Setting.consumes.status_success, :citrine_id => @citrine.id)
        end
        redirect_to admin_citrine_path(@citrine)
      else
        render :edit
      end
    end
  end

end
