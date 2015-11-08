ActiveAdmin.register Order do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params [
                    :id, :user_id, :order_number,
                    :aasm_state, :notes, :amount,
                    :vat, :order_receiver_id, :cr,
                    :requested_at, :created_at, :updated_at,
                    :full_name, :email, :phone,
                    :address, :city, :country, :post
                ]

  index do
    id_column
    column :full_name
    column :phone
    column :aasm_state
    column :created_at
    actions
  end

  form do |f|
    inputs 'Action Available' do
      input :aasm_state, as: :select, collection: f.object.class.aasm.states_for_select
    end
    inputs 'Order Details' do
      input :full_name
      input :phone
      input :address
    end

    inputs "Amount" do
      input :item_count
      input :amount
    end

    actions
  end

  controller do
    def find_resource
      Order.where(order_number: params[:id]).first!
    end
  end

end
