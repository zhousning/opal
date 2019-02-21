ActiveAdmin.register Trade  do

  permit_params  :min, :max, :total_purchase, :price, :volume

  actions :all, :except => [:destroy]

  menu label: "交易中心", :priority => 20 
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :min, :label => Setting.trades.min
  filter :max, :label => Setting.trades.max
  filter :total_purchase, :label => Setting.trades.total_purchase
  filter :price, :label => Setting.trades.price
  filter :volume, :label => Setting.trades.volume

  index :title=>"交易设置" do
    selectable_column
    id_column
    
    column Setting.trades.min, :min
    column Setting.trades.max, :max
    column Setting.trades.total_purchase, :total_purchase
    column Setting.trades.price, :price
    column Setting.trades.volume, :volume

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
      f.input :total_purchase, :label => Setting.trades.total_purchase 
      f.input :price, :label => Setting.trades.price 
      f.input :volume, :label => Setting.trades.volume 
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
      row Setting.trades.total_purchase do
        trade.total_purchase
      end
      row Setting.trades.price do
        trade.price
      end
      row Setting.trades.volume do
        trade.volume
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
