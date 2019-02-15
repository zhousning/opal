ActiveAdmin.register TradeOrder  do

  permit_params  :number, :wayno, :name, :phone, :address

  menu label: "买家订单", :priority => 5 
  config.per_page = 20
  config.sort_order = "id_asc"

  index :title=>"买家订单" do
    selectable_column
    id_column
    
    column Setting.trade_orders.number, :number
    column Setting.trade_orders.price, :price
    column Setting.trade_orders.state, :state do |f|
      f.trade_order_state(f.state)
    end
    column Setting.trade_orders.wayno, :wayno
    column Setting.trade_orders.name, :name
    column Setting.trade_orders.phone, :phone
    column Setting.trade_orders.address, :address

    column "创建时间", :created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间", :updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  
  filter :number, :label => Setting.trade_orders.number 
  filter :price, :label => Setting.trade_orders.price 
  filter :state, :label => Setting.trade_orders.state
  filter :wayno, :label => Setting.trade_orders.wayno
  filter :name, :label => Setting.trade_orders.name 
  filter :phone, :label => Setting.trade_orders.phone 
  filter :address, :label => Setting.trade_orders.address 
  filter :created_at

  form  :title=>"编辑订单" do |f|
    f.inputs "详情" do
      f.input :number, :label => Setting.trade_orders.number 
      f.input :name, :as => :kindeditor, :label => Setting.trade_orders.name 
      f.input :phone, :label => Setting.trade_orders.phone 
      f.input :address, :label => Setting.trade_orders.address 
      f.input :wayno, :label => Setting.trade_orders.wayno
    end
    f.actions
  end

  show :title=>'订单详情' do
    attributes_table do
      row "ID" do
        trade_order.id
      end
      
      row Setting.trade_orders.number do
        trade_order.number
      end
      row Setting.trade_orders.price do
        trade_order.price
      end
      row Setting.trade_orders.state do
        trade_order.state
      end
      row Setting.trade_orders.name do
        trade_order.name
      end
      row Setting.trade_orders.phone do
        trade_order.phone
      end
      row Setting.trade_orders.address do
        trade_order.address
      end
      row Setting.trade_orders.wayno do
        trade_order.wayno
      end

      row "创建时间" do
        trade_order.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        trade_order.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "操作" do
        link_to("发货", trade_order_departed_admin_trade_order_path(trade_order.id))
      end
    end
  end

  member_action :trade_order_departed do
    trade_order = TradeOrder.find(params[:id])
    trade_order.depart
    redirect_to admin_trade_order_path(params[:id])
  end

end
