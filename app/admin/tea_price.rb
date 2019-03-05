ActiveAdmin.register TeaPrice  do

  permit_params  :price

  menu label: "茶叶价格", :priority => 8 
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :price, :label => Setting.tea_prices.price
  filter :created_at

  index :title=>"茶叶价格" do
    selectable_column
    id_column
    
    column Setting.tea_prices.price, :price

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
      
      f.input :price, :label => Setting.tea_prices.price 
    end
    f.actions
  end

  show :title=>'茶叶价格' do
    attributes_table do
      row "ID" do
        tea_price.id
      end
      
      row Setting.tea_prices.price do
        tea_price.price
      end

      row "创建时间" do
        tea_price.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        tea_price.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

end
