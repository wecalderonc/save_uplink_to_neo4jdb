require './config/application.rb'
require './spec/spec_helper.rb'
require './app/models/alarm_type.rb'

RSpec.describe AlarmType, type: :model do

  it { is_expected.to define_property :value, :Integer }
  it { is_expected.to define_property :name, :String }
  it { is_expected.to define_property :type, :String }

  it { is_expected.to have_one(:alarm).with_direction(:in) }

  describe "Validations" do
    it "name, type and value are required" do
      expect(subject).to_not be_valid

      expected_errors = {
        :name=>["can't be blank"],
        :type=>["can't be blank", "is not included in the list"],
        :value=>["can't be blank"],
      }

      expect(subject.errors.messages).to eq(expected_errors)
    end
  end

  describe "Validation hardware value" do
    let(:alarm_type) { build(:alarm_type, type: "hardware") }

    it "type should be valid" do
      expect(alarm_type).to be_valid
    end
  end

  describe "Validation software value" do
    let(:alarm_type) { build(:alarm_type, type: "software") }

    it "type should be valid" do
      expect(alarm_type).to be_valid
    end
  end

  describe "Validation dog value" do
    let(:alarm_type) { build(:alarm_type, type: "dog") }

    it "type should not be valid" do
      expect(alarm_type).to_not be_valid

      expected_errors = {
        :type=>["is not included in the list"],
      }

      expect(alarm_type.errors.messages).to eq(expected_errors)
    end
  end

  describe "Validation string empty value" do
    let(:alarm_type) { build(:alarm_type, type: "") }

    it "type should not be valid" do
      expect(alarm_type).to_not be_valid

      expected_errors = {
        :type=>["can't be blank", "is not included in the list"],
      }

      expect(alarm_type.errors.messages).to eq(expected_errors)
    end
  end

  describe "Validation of integer value" do
    let(:alarm_type) { build(:alarm_type, type: 123456) }

    it "type should not be valid" do
      expect(alarm_type).to_not be_valid

      expected_errors = {
        :type=>["is not included in the list"],
      }

      expect(alarm_type.errors.messages).to eq(expected_errors)
    end
  end
end
