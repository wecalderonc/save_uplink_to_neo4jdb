require './config/application.rb'
require './app/services/alarms/create/execute.rb'


RSpec.describe Alarms::Create::Execute do

  describe "#call" do
    let(:alarm) { create(:alarm, value: "0000") }
    let(:input) {
      {
        object: alarm,
        type: :hardware,
        model: :alarm
      }
    }

    context "When the object is an Alarm" do
      context "When all the operations are successful" do
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:does_not_apply.to_s)

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
      context "When all the operations are successful" do
        it "Should return a Success response" do
          input[:object] = build(:battery_level, value: "0001")
          input[:model] = :battery_level
          alarm_type_count = AlarmType.all.count

          response = subject.(input)

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
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

    context "When the object is an accumulator" do
      context "When all the operations are successful" do
        it "Should return a Success response" do
          input[:object] = build(:accumulator)
          input[:model] = :accumulator
          input[:type] = :software
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
