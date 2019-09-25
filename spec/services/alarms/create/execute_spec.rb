require './config/application.rb'
require './app/services/alarms/create/execute.rb'


RSpec.describe Alarms::Create::Execute do

  describe "#call" do

    before :each do
     AlarmType.destroy_all
    end

    context "When the object is an Alarm" do
      let(:alarm) { create(:alarm, value: "0000") }
      let(:input) {
        {
          object: alarm,
          type: :hardware,
          model: :alarm
        }
      }

      context "When all the operations are successful alarm type doesnt apply" do
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:does_not_apply.to_s)

        end
      end

      context "When all the operations are successful alarm type power_connection" do

        let(:alarm) { create(:alarm, value: "0001") }
        let(:input) {
          {
            object: alarm,
            type: :hardware,
            model: :alarm
          }
        }
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:power_connection.to_s)

        end
      end

      context "When all the operations are successful alarm type induced_site_alarm" do

        let(:alarm) { create(:alarm, value: "0002") }
        let(:input) {
          {
            object: alarm,
            type: :hardware,
            model: :alarm
          }
        }
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:induced_site_alarm.to_s)

        end
      end

      context "When all the operations are successful alarm type sos" do

        let(:alarm) { create(:alarm, value: "0003") }
        let(:input) {
          {
            object: alarm,
            type: :hardware,
            model: :alarm
          }
        }
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:sos.to_s)

        end
      end

      context "When the validation step fails" do
        it "Should return a Failure response with type message" do
          input.delete(:type)

          response = subject.(input)

          expected_response = {:type=>["is missing"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with model message" do
          input.delete(:model)

          response = subject.(input)

          expected_response = "The model is not in the list"

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with object message" do
          input.delete(:object)

          response = subject.(input)

          expected_response = {:object=>["is missing"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with invalid object" do
          input[:object] = Alarm.new

          response = subject.(input)

          expected_response = {:valid_object => ["Object is not valid"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end
      end
    end

    context "When the object is a battery_level" do
      let(:battery_level) { create(:battery_level, value: "0001") }
      let(:input) {
        {
          object: battery_level,
          type: :hardware,
          model: :battery_level
        }
      }
      context "When all the operations are successful with alarm low_battery" do
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count


          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:low_battery.to_s)
        end
      end

      context "When all the operations are successful without alarm" do
        let(:battery_level) { create(:battery_level, value: "0000") }
        let(:input) {
          {
            object: battery_level,
            type: :hardware,
            model: :battery_level
          }
        }
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count)
        end
      end

      context "When the validation step fails" do
        it "Should return a Failure response with type message" do
          input.delete(:type)

          response = subject.(input)

          expected_response = {:type=>["is missing"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with model message" do
          input.delete(:model)

          response = subject.(input)

          expected_response = "The model is not in the list"

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with object message" do
          input.delete(:object)

          response = subject.(input)

          expected_response = {:object=>["is missing"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with invalid object" do
          input[:object] = BatteryLevel.new

          response = subject.(input)

          expected_response = {:valid_object => ["Object is not valid"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end
      end
    end

    #TO COMPLETE WITH JEI
    context "When the object is an accumulator" do
      let(:accumulator) { create(:accumulator, value: "0000") }
      let(:input) {
        {
          object: accumulator,
          type: :software,
          model: :accumulator
        }
      }
      context "When all the operations are successful" do
        it "Should return a Success response" do
          response = subject.(input)

          expect(response).to be_success
        end
      end

      context "When the validation step fails" do
        it "Should return a Failure response with type message" do
          input.delete(:type)

          response = subject.(input)

          expected_response = {:type=>["is missing"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with model message" do
          input.delete(:model)

          response = subject.(input)

          expected_response = "The model is not in the list"

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with object message" do
          input.delete(:object)

          response = subject.(input)

          expected_response = {:object=>["is missing"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end

        it "Should return a Failure response with invalid object" do
          input[:object] = Accumulator.new

          response = subject.(input)

          expected_response = {:valid_object => ["Object is not valid"]}

          expect(response).to be_failure
          expect(response.failure[:error]).to eq(expected_response)
        end
      end
    end
  end
end
