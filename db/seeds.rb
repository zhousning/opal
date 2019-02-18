# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.create(:name => Setting.roles.super_admin)

admin_permissions = Permission.create(:name => Setting.permissions.super_admin, :subject_class => Setting.admins.class_name, :action => "manage")

role.permissions << admin_permissions

user = User.new(:phone => Setting.admins.phone, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)
user.save!

user.roles = []
user.roles << role

Account.create(:coin => 43241, :status => Setting.accounts.enable, :user_id => user.id)

User.create!(:phone => "15763703188", :password => "15763703188", :password_confirmation => "15763703188")

AdminUser.create!(:phone => Setting.admins.phone, :email => Setting.admins.email, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)

SharePool.create!(today_enter: 17890, total: 3242341, user_total:21234, pay: 453232, ware_total:3332, gross_sale: 1232, diamond: 9580, current_total: 3423, own_tea: 1.84)

Notice.create!(:title => "茶源世界", :content => "欢迎来到茶源世界")
