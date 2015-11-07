module Customer
class OrdersController < CustomerController
  before_action :set_customer_order, only: [:show, :edit, :update, :destroy]

  # GET /customer/orders
  # GET /customer/orders.json
  before_action :authenticate_user!
  before_filter :prevent_non_customer_user

  def index
    @customer_orders = current_user.orders
  end

  # GET /customer/orders/1
  # GET /customer/orders/1.json
  def show
  end

  # GET /customer/orders/new
  def new
    @customer_order = Order.new
  end

  # GET /customer/orders/1/edit
  def edit
  end

  # POST /customer/orders
  # POST /customer/orders.json
  def create
    @customer_order = Order.new(customer_order_params)

    respond_to do |format|
      if @customer_order.save
        format.html { redirect_to customer_order_path(@customer_order), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @customer_order }
      else
        format.html { render :new }
        format.json { render json: @customer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer/orders/1
  # PATCH/PUT /customer/orders/1.json
  def update
    respond_to do |format|
      if @customer_order.update(customer_order_params)
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
    @customer_order.destroy
    respond_to do |format|
      format.html { redirect_to customer_orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_order
      @customer_order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_order_params
      params.require(:customer_order).permit(
          [
              :id, :user_id, :order_number, :aasm_state, :notes,
           :amount, :vat, :order_receiver_id,
           :cr, :requested_at, :created_at, :updated_at
          ]
      )
    end
end
end
