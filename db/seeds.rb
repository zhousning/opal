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

user = User.new(:phone => Setting.admins.phone, :password => Setting.admins.phone, :password_confirmation => Setting.admins.phone)
user.save!

user.roles = []
user.roles << role


u = User.create(:phone => "15763703188", :password => "15763703188", :password_confirmation => "15763703188")

AdminUser.create!(phone: '15859859888', email: 'mytea@world.com', password: 'myteaworld', password_confirmation: 'myteaworld')
