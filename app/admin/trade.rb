ActiveAdmin.register Trade  do

  permit_params  :min, :max, :total_purchase, :price, :volume, :start, :end

  actions :all, :except => [:destroy]

  menu label: "交易中心", :priority => 6 
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
    column Setting.trades.start, :start do |f|
      f.start.strftime('%H:%M')
    end
    column Setting.trades.end, :end do |f|
      f.end.strftime('%H:%M')
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
      f.input :start, :label => Setting.trades.start 
      f.input :end, :label => Setting.trades.end 
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

      row Setting.trades.start do
        trade.start.strftime('%H:%M')
      end
      row Setting.trades.end do
        trade.end.strftime('%H:%M')
      end
    end
  end

end
