ActiveAdmin.register ExtractCash  do

  permit_params  :coin, :status

  menu label: "用户提现", :priority => 6 
  config.per_page = 20
  config.sort_order = "id_asc"

  actions :all, :except => [:new, :edit, :destroy]
  
  filter :status, :label => Setting.extract_cashes.status, as: :select, collection: [[Setting.extract_cashes.pending_title, Setting.extract_cashes.pending], [Setting.extract_cashes.agree_title, Setting.extract_cashes.agree], [Setting.extract_cashes.disagree_title,Setting.extract_cashes.disagree]]
  filter :coin, :label => Setting.extract_cashes.coin
  filter :created_at

  index :title=>"用户提现" do
    selectable_column
    id_column
    
    column Setting.extract_cashes.coin, :coin
    column Setting.extract_cashes.status, :status do |f|
      f.state
    end

    column "创建时间", :created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  form do |f|
    f.inputs "详情" do
      
      f.input :coin, :label => Setting.extract_cashes.coin, :min => 0.01 
      f.input :status, :label => Setting.extract_cashes.status 
    end
    f.actions
  end

  show :title=>'用户提现' do
    attributes_table do
      row "ID" do
        extract_cash.id
      end
      
      row Setting.extract_cashes.coin do
        extract_cash.coin
      end
      row Setting.extract_cashes.status do
        extract_cash.status
      end
      row Setting.users.name do
        extract_cash.user.name
      end
      row Setting.users.phone do
        extract_cash.user.phone
      end
      row Setting.users.alipay do
        extract_cash.user.alipay
      end

      row "创建时间" do
        extract_cash.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        extract_cash.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "审核" do
        link_to(Setting.extract_cashes.agree_title, pass_admin_extract_cash_path(extract_cash.id)) + "  " +
        link_to(Setting.extract_cashes.disagree_title, reject_admin_extract_cash_path(extract_cash.id))
      end
    end
  end

  member_action :pass do
    extract_cash = ExtractCash.find(params[:id])
    extract_cash.agree
    extract_cash.user.account.sub_freeze_coin(extract_cash.coin)
    redirect_to admin_extract_cash_path(params[:id])
  end

  member_action :reject do
    extract_cash = ExtractCash.find(params[:id])
    extract_cash.disagree
    redirect_to admin_extract_cash_path(params[:id])
  end
end
