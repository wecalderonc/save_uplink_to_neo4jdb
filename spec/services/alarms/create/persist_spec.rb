require './config/application.rb'
require './app/services/alarms/create/persist.rb'

RSpec.describe Alarms::Create::Persist do

  describe "#call" do

    before :each do
     AlarmType.destroy_all
    end

    context "input with battery level" do
      let(:battery_level) { build(:battery_level, value: 0001) }
      let(:alarm) { create(:alarm, value: "0000") }
      let(:input)  {
        {
          object: battery_level,
          model: :battery_level,
          type: :hardware,
          alarm_name: :low_battery,
          alarm: alarm,
          last_digit: 1
        }
      }

      context "The input is valid with battery_level with alarm" do
        it "Should return a Success response" do

          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:low_battery.to_s)
        end
      end

      context "The input doesnt have alarm_name with battery_level" do
        it "Should return a Success response" do
          input.delete(:alarm_name)
          alarm_type_count = AlarmType.all.count

          response = subject.call(input)

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count)
        end
      end
    end

    context "Input with alarm" do
      let(:alarm) { build(:alarm) }
      let(:input)  {
        {
          object: alarm,
          model: :alarm,
          type: :hardware,
          alarm_name: :power_connection,
          last_digit: 1
        }
      }
      context "The input is valid with alarm power_connection" do
        it "Should return a Success response" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:power_connection.to_s)
        end
      end

      context "The input does have alarm_name with alarm in does_not_apply" do
        let(:alarm) { build(:alarm) }
        let(:input)  {
          {
            object: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :does_not_apply,
            last_digit: 8
          }
        }

        it "Should return a Success response without creating one alarm type" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:does_not_apply.to_s)
        end
      end

      context "The input does have alarm_name with alarm in does_not_apply" do
        let(:alarm) { build(:alarm) }
        let(:input)  {
          {
            object: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :induced_site_alarm,
            last_digit: 2
          }
        }

        it "Should return a Success response without creating one alarm type" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:induced_site_alarm.to_s)
        end
      end

      context "The input does have alarm_name with alarm in does_not_apply" do
        let(:alarm) { build(:alarm) }
        let(:input)  {
          {
            object: alarm,
            model: :alarm,
            type: :hardware,
            alarm_name: :sos,
            last_digit: 3
          }
        }

        it "Should return a Success response without creating one alarm type" do
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:sos.to_s)
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
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 2)
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
          alarm_type_count = AlarmType.all.count

          response = subject.(input)
          new_alarm_type = AlarmType.all.order(created_at: :asc).last

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count + 1)
          expect(new_alarm_type.name).to match(:imposible_consumption.to_s)
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
          alarm_type_count = AlarmType.all.count

          response = subject.(input)

          expect(response).to be_success
          expect(AlarmType.all.count).to match(alarm_type_count)
        end
      end
    end
  end
end
