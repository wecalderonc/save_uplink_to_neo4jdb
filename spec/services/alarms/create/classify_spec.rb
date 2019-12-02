require './config/application.rb'
require './app/services/alarms/create/classify.rb'

RSpec.describe Alarms::Create::Classify do

  describe "#call" do

    before :each do
     AlarmType.destroy_all
     Alarm.destroy_all
     Uplink.destroy_all
     Thing.destroy_all
     Accumulator.destroy_all
    end

    context "input with battery level" do
      let(:battery_level) { build(:battery_level, value: "0001") }
      let(:input)  {
        {
          object: battery_level,
          model: :battery_level,
          type: :hardware,
        }
      }

      context "The input is valid with battery_level with alarm low battery" do
        it "Should return a Success response" do

          response = subject.call(input)

          expected_response = {
            object: battery_level,
            model: :battery_level,
            type: :hardware,
            alarm_name: :low_battery,
            last_digit: 1
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end

      context "The input is valid with battery_level with value without alarm" do
        let(:battery_level) { build(:battery_level, value: "0002") }
        let(:input)  {
          {
            object: battery_level,
            model: :battery_level,
            type: :hardware,
          }
        }
        it "Should return a Success response without alarm_name generated" do

          response = subject.call(input)

          expected_response = {
            object: battery_level,
            model: :battery_level,
            type: :hardware
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end
    end

    context "Input with alarm" do
      let(:alarm) { build(:alarm, value: "0000") }
      let(:input)  {
        {
          object: alarm,
          model: :alarm,
          type: :hardware
        }
      }
      context "The input is valid without alarm or wrong digit" do
        it "Should return a Success response" do
          response = subject.call(input)

          expected_response = {
            object: alarm,
            alarm: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :does_not_apply,
            last_digit: 0
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end

      context "The input is valid with value 0001" do
        let(:alarm) { build(:alarm, value: "0001") }
        let(:input)  {
          {
            object: alarm,
            model: :alarm,
            type: :hardware
          }
        }

        it "Should return a Success response with alarm_name power_connection" do
          response = subject.call(input)

          expected_response = {
            object: alarm,
            alarm: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :power_connection,
            last_digit: 1
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end

      context "The input is valid with value 0002" do
        let(:alarm) { build(:alarm, value: "0002") }
        let(:input)  {
          {
            object: alarm,
            model: :alarm,
            type: :hardware
          }
        }

        it "Should return a Success response with alarm_name induced_site_alarm" do
          response = subject.call(input)

          expected_response = {
            object: alarm,
            alarm: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :induced_site_alarm,
            last_digit: 2
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end

      context "The input is valid with value 0003" do
        let(:alarm) { build(:alarm, value: "0003") }
        let(:input)  {
          {
            object: alarm,
            model: :alarm,
            type: :hardware
          }
        }

        it "Should return a Success response with alarm_name sos" do
          response = subject.call(input)

          expected_response = {
            object: alarm,
            alarm: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :sos,
            last_digit: 3
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end

      context "The input is valid with value 0004" do
        let(:alarm) { build(:alarm, value: "0004") }
        let(:input)  {
          {
            object: alarm,
            model: :alarm,
            type: :hardware
          }
        }

        it "Should return a Success response with alarm_name does_not_apply" do
          response = subject.call(input)

          expected_response = {
            object: alarm,
            alarm: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :does_not_apply,
            last_digit: 4
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end
    end

    context "Input with accumulator" do
      context "The current_accumulator is 1 > last_accumulator" do
        let(:thing) { create(:thing, flow_per_minute: 10) }
        let(:uplink1) { create(:uplink, time: 1568887200, thing: thing) }
        let(:uplink2) { create(:uplink, time: 1568890800, thing: thing) }
        let!(:accumulator1) { create(:accumulator, value: "00000000", uplink: uplink1) }
        let(:accumulator2) { build(:accumulator, value: "00000001", uplink: uplink2) }
        let(:input)  {
          {
            object: accumulator2,
            model: :accumulator,
            type: :software,
          }
        }

        it "Should return a Success response with two created alarms" do
          response = subject.call(input)

          expected_response = {
            object: accumulator2,
            model: :accumulator,
            type: :software,
            accumulator_alarm_name: {
              unexpected_dump: false,
              imposible_consumption: false
            }
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end

      context "The current_accumulator is 100 > last_accumulator" do
        let(:thing) { create(:thing, flow_per_minute: 10) }
        let(:uplink1) { create(:uplink, time: 1568887200, thing: thing) }
        let(:uplink2) { create(:uplink, time: 1568890800, thing: thing) }
        let!(:accumulator1) { create(:accumulator, value: "00000000", uplink: uplink1) }
        let(:accumulator2) { build(:accumulator, value: "00001000", uplink: uplink2) }
        let(:input)  {
          {
            object: accumulator2,
            model: :accumulator,
            type: :software,
          }
        }

        it "Should return a Success response with two created alarms unexpected_dump false and imposible_consumption true" do
          response = subject.call(input)

          expected_response = {
            object: accumulator2,
            model: :accumulator,
            type: :software,
            accumulator_alarm_name: {
              unexpected_dump: false,
              imposible_consumption: true
            }
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end

      context "The current_accumulator is 100 > last_accumulator" do
        let(:thing) { create(:thing, flow_per_minute: 10) }
        let(:uplink1) { create(:uplink, time: 1568887200, thing: thing) }
        let(:uplink2) { create(:uplink, time: 1568890800, thing: thing) }
        let!(:accumulator1) { create(:accumulator, value: "00001000", uplink: uplink1) }
        let(:accumulator2) { build(:accumulator, value: "00000001", uplink: uplink2) }
        let(:input)  {
          {
            object: accumulator2,
            model: :accumulator,
            type: :software,
          }
        }

        it "Should return a Success response with two created alarms in true" do
          response = subject.call(input)

          expected_response = {
            object: accumulator2,
            model: :accumulator,
            type: :software,
            accumulator_alarm_name: {
              unexpected_dump: true,
              imposible_consumption: true
            }
          }

          expect(response).to be_success
          expect(response.success).to eq(expected_response)
        end
      end
    end
  end
end
