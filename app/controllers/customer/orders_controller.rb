module Customer
  class OrdersController < CustomerController
    before_action :set_customer_order, only: [:show, :edit, :update, :destroy, :track]

    # GET /customer/orders
    # GET /customer/orders.json
    before_action :authenticate_user!, except: [:track]
    before_filter :prevent_non_customer_user, except: [:track]

    def index
      @customer_orders = current_user.orders
    end

    # GET /customer/orders/1
    # GET /customer/orders/1.json
    def show
    end

    def track
      if params[:id].blank?
        redirect_to root_url, notice: 'Please enter your tracking id and try again'
      end

    end

    # GET /customer/orders/new
    def new
      @order = current_user.orders.new
      @order.assign_user_information
    end

    # GET /customer/orders/1/edit
    def edit
    end

    # POST /customer/orders
    # POST /customer/orders.json
    def create
      @order = current_user.orders.new(customer_order_params)

      respond_to do |format|
        if @order.save
          format.html { redirect_to customer_order_path(@order), notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /customer/orders/1
    # PATCH/PUT /customer/orders/1.json
    def update
      respond_to do |format|
        if @order.update(customer_order_params)
          format.html { redirect_to customer_order_path @customer_order, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @customer_order }
        else
          format.html { render :edit }
          format.json { render json: @customer_order.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /customer/orders/1
    # DELETE /customer/orders/1.json
    def destroy
      @order.destroy
      respond_to do |format|
        format.html { redirect_to customer_orders_url, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_order
      @order = Order.find_by(order_number: params[:id]) rescue nil
      unless @order
        redirect_to root_url, notice: 'Invalid order ID.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_order_params
      params.require(:customer_order).permit(
          [
              :id, :user_id, :order_number,
              :aasm_state, :notes, :amount,
              :vat, :order_receiver_id, :cr,
              :requested_at, :created_at, :updated_at,
              :full_name, :email, :phone,
              :address, :city, :country, :post
          ]
      )
    end
  end
end
