ActiveAdmin.register SharePool  do

  permit_params  :today_enter, :total, :user_total, :pay, :ware_total, :gross_sale, :diamond, :current_total, :own_tea

  actions :all, :except => [:destroy]

  menu label: "分红池", :priority => 8 
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :today_enter, :label => Setting.share_pools.today_enter
  filter :total, :label => Setting.share_pools.total
  filter :user_total, :label => Setting.share_pools.user_total
  filter :pay, :label => Setting.share_pools.pay
  filter :ware_total, :label => Setting.share_pools.ware_total
  filter :gross_sale, :label => Setting.share_pools.gross_sale
  filter :diamond, :label => Setting.share_pools.diamond
  filter :current_total, :label => Setting.share_pools.current_total
  filter :own_tea, :label => Setting.share_pools.own_tea
  filter :created_at

  index :title=>"分红池" do
    selectable_column
    id_column
    
    column Setting.share_pools.today_enter, :today_enter
    column Setting.share_pools.total, :total
    column Setting.share_pools.user_total, :user_total
    column Setting.share_pools.pay, :pay
    column Setting.share_pools.ware_total, :ware_total
    column Setting.share_pools.gross_sale, :gross_sale
    column Setting.share_pools.diamond, :diamond
    column Setting.share_pools.current_total, :current_total
    column Setting.share_pools.own_tea, :own_tea

    actions
  end

  form do |f|
    f.inputs "详情" do
      
      f.input :today_enter, :label => Setting.share_pools.today_enter 
      f.input :total, :label => Setting.share_pools.total 
      f.input :user_total, :label => Setting.share_pools.user_total 
      f.input :pay, :label => Setting.share_pools.pay 
      f.input :ware_total, :label => Setting.share_pools.ware_total 
      f.input :gross_sale, :label => Setting.share_pools.gross_sale 
      f.input :diamond, :label => Setting.share_pools.diamond
      f.input :current_total, :label => Setting.share_pools.current_total
      f.input :own_tea, :label => Setting.share_pools.own_tea
    end
    f.actions
  end

  show :title=>'分红池' do
    attributes_table do
      row "ID" do
        share_pool.id
      end
      
      row Setting.share_pools.today_enter do
        share_pool.today_enter
      end
      row Setting.share_pools.total do
        share_pool.total
      end
      row Setting.share_pools.user_total do
        share_pool.user_total
      end
      row Setting.share_pools.pay do
        share_pool.pay
      end
      row Setting.share_pools.ware_total do
        share_pool.ware_total
      end
      row Setting.share_pools.gross_sale do
        share_pool.gross_sale
      end
      row Setting.share_pools.diamond do
        share_pool.diamond
      end
      row Setting.share_pools.current_total do
        share_pool.current_total
      end
      row Setting.share_pools.own_tea do
        share_pool.own_tea
      end

      row "创建时间" do
        share_pool.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        share_pool.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

end
