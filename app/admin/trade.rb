ActiveAdmin.register Trade  do

  permit_params  :min, :max

  actions :all, :except => [:new, :destroy]

  menu label: "交易设置", :priority => 20 
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :min, :label => Setting.trades.min
  filter :max, :label => Setting.trades.max
  filter :created_at

  index :title=>"交易设置" do
    selectable_column
    id_column
    
    column Setting.trades.min, :min
    column Setting.trades.max, :max

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
      
      f.input :min, :label => Setting.trades.min 
      f.input :max, :label => Setting.trades.max 
    end
    f.actions
  end

  show :title=>'交易设置' do
    attributes_table do
      row "ID" do
        trade.id
      end
      
      row Setting.trades.min do
        trade.min
      end
      row Setting.trades.max do
        trade.max
      end

      row "创建时间" do
        trade.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        trade.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

end
