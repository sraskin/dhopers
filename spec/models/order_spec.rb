require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'with valid data' do
    let(:order) { create(:order, :requested) }

    it 'should be a valid order' do
      expect(order).to be_valid
    end

    it 'is a requested order' do
      expect(order.requested?).to be_truthy
    end

    it 'can be accepted' do
      expect(order.may_accept?).to be_truthy
    end

    it "can't be collected with out accepting the order" do
      expect(order.may_process?).to be_falsey
    end

    context "when managing orders" do

      subject { order.accept! }

      it 'should create order event if accepted' do
        expect { subject }.to change(OrderEvent, :count)
      end

      context 'when a new event triggered' do
        let(:event) { order.reload.order_events.last }

        before { subject }

        it 'should have event with updated state' do
          expect(event.current_state).to be == order.aasm_state
        end

        it 'should not have any previous step' do
          expect(event.previous_state).to be == Order::REQUESTED.to_s
        end

        context 'when order collection is in process' do
          before { order.collect! }

          it 'should have event with updated state' do
            expect(event.current_state).to be == order.reload.aasm_state
          end

          it 'should not have any previous step' do
            expect(event.previous_state).to be == Order::ACCEPTED.to_s
          end

          context 'when order laundry process started' do
            before { order.process! }

            it 'should have event with updated state' do
              expect(event.current_state).to be == order.reload.aasm_state
            end

            it 'should not have any previous step' do
              expect(event.previous_state).to be == Order::COLLECTING.to_s
            end
          end
        end
      end
    end

    context 'order number' do
      let(:order) { create(:order, :requested) }
      let(:orders) { create_list(:order, 1000000000, :requested) }

        it "should have a order number" do
          expect(order.order_number).to be_present
        end

        it 'should be unique' do
          expect(Order.where.not(id: order.id).exists?(order_number: order.order_number)).to be_falsey
        end
    end
  end

  context "when order delivered" do
    let(:order) { create(:order, :processed) }

    subject { order.mark_as_delivered! }

    it "creates a payment history" do
      expect { subject }.to change(Payment, :count).by(1)
    end
  end
end
