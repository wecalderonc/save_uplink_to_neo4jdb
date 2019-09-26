require './config/application.rb'
require './app/services/alarms/create/generate_alarm.rb'

RSpec.describe Alarms::Create::GenerateAlarm do

  describe "#call" do
    context "input with battery level" do
      let(:battery_level) { build(:battery_level, value: "0001") }
      let(:input)  {
        {
          object: battery_level,
          model: :battery_level,
          type: :hardware,
          alarm_name: :low_battery
        }
      }

      context "The input is valid with battery_level with alarm" do
        it "Should return a Success response" do
          response = subject.call(input)

          expect(response).to be_success
          expect(response.success[:alarm].value).to match("0000")
        end
      end

      context "The input doesnt have alarm_name with battery_level" do
        it "Should return a Success response" do
          input.delete(:alarm_name)
          response = subject.call(input)

          expect(response).to be_success
          expect(response.success[:alarm]).to match(nil)
        end
      end
    end

    context "Input with accumulator" do
      context "The input is true in unexpected_dump and imposible_consumption" do
        let(:accumulator) { build(:accumulator) }
        let(:input)  {
          {
            object: accumulator,
            model: :accumulator,
            type: :hardware,
            accumulator_alarm_name: {
              unexpected_dump: true,
              imposible_consumption: true
            }
          }
        }

        it "Should return a Success response with two created alarms" do
          response = subject.call(input)

          expect(response).to be_success
          expect(response.success[:impossible_consumption_alarm].value).to match("0000")
          expect(response.success[:unexpected_dump_alarm].value).to match("0000")
        end
      end

      context "The input is true imposible_consumption and false unexpected_dump" do
        let(:accumulator) { build(:accumulator) }
        let(:input)  {
          {
            object: accumulator,
            model: :accumulator,
            type: :hardware,
            accumulator_alarm_name: {
              unexpected_dump: false,
              imposible_consumption: true
            }
          }
        }

        it "Should return a Success response with one created alarm" do
          response = subject.call(input)

          expect(response).to be_success
          expect(response.success[:alarm].value).to match("0000")
        end
      end

      context "The input is false in unexpected_dump and imposible_consumption" do
        let(:accumulator) { build(:accumulator) }
        let(:input)  {
          {
            object: accumulator,
            model: :accumulator,
            type: :hardware,
            accumulator_alarm_name: {
              unexpected_dump: false,
              imposible_consumption: false
            }
          }
        }

        it "Should return a Success response without created alarms" do
          response = subject.call(input)

          expect(response).to be_success
          expect(response.success[:alarm]).to match(nil)
          expect(response.success[:alarm2]).to match(nil)
        end
      end
    end

  end
end
