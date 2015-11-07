ActiveAdmin.register Order do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params [
                  :id, :user_id, :order_number,
                  :aasm_state, :notes, :amount,
                  :vat, :order_receiver_id,
                  :cr, :requested_at, :created_at,
                  :updated_at
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
