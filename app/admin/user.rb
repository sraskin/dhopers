ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params [
                  :id, :first_name, :last_name, :created_at,
                  :updated_at, :email, :password,
                  :password_confirmation, :remember_created_at,
                  :sign_in_count, :current_sign_in_at,
                  :last_sign_in_at, :current_sign_in_ip,
                  :last_sign_in_ip, :role
              ]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
