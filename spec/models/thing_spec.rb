require './config/application.rb'
require './spec/spec_helper.rb'
require './app/models/thing.rb'

RSpec.describe Thing, :type => :model do

  it { is_expected.to define_property :name, :String }
  it { is_expected.to define_property :status, :String }
  it { is_expected.to define_property :pac, :String }
  it { is_expected.to define_property :company_id, :String }
  it { is_expected.to define_property :longitude, :Float }
  it { is_expected.to define_property :latitude, :Float }
  it { is_expected.to define_property :latitude, :Float }
  it { is_expected.to define_property :flow_per_minute, :Integer }

  it { is_expected.to have_one(:uplinks).with_direction(:out) }
  it { is_expected.to have_one(:locates).with_direction(:out) }
  it { is_expected.to have_one(:valve_state).with_direction(:out) }

  it { is_expected.to have_many(:owner).with_direction(:in) }
  it { is_expected.to have_many(:operator).with_direction(:in) }
  it { is_expected.to have_many(:viewer).with_direction(:in) }

  describe "Validations" do
    it "email and password are required" do
      expect(subject).to_not be_valid

      expected_errors = {
        :name=>["can't be blank"],
        :status=>["can't be blank"],
        :pac=>["can't be blank"],
        :latitude => ["can't be blank"],
        :longitude => ["can't be blank"],
        :company_id=>["can't be blank"],
        :flow_per_minute=>["can't be blank"]
      }

      expect(subject.errors.messages).to eq(expected_errors)
    end
  end

  describe "#last_uplinks" do
    let(:thing) { create(:thing) }

    context "When there are uplinks" do
      it "Should return the last uplink" do
        create(:uplink, thing: thing, created_at: Time.now)
        create(:uplink, thing: thing, created_at: Time.now + 1)
        uplink = create(:uplink, thing: thing, created_at: Time.now + 2)

        last_uplink = thing.last_uplinks.last

        expect(last_uplink.id).to eq(uplink.id)
      end

      it "Should return the last uplinks" do
        create(:uplink, thing: thing, created_at: Time.now)
        create(:uplink, thing: thing, created_at: Time.now + 1)
        uplink = create(:uplink, thing: thing, created_at: Time.now + 2)

        last_uplinks = thing.last_uplinks(3)

        expect(last_uplinks.length).to eq(3)
      end
    end

    context "When there are not uplinks" do
      it "Should return the nil" do
        last_uplink = thing.last_uplinks.last

        expect(last_uplink).to be_nil
      end
    end
  end

  context "Validate units" do
    context "The units is empty" do
      it "Should be valid" do
        thing = create(:thing)

        expect(thing).to be_valid
      end
    end

    context "The unit has one value" do
      it "Should be valid" do
        thing = create(:thing, units: { liter: 200 })

        expect(thing).to be_valid
      end
    end

    context "The unit has n empty hash" do
      it "Should be valid" do
        thing = create(:thing, units: {})

        expect(thing).to be_valid
      end
    end

    context "The unit value is zero" do
      it "Should be invalid" do
        thing = build(:thing, units: { my_unit: 0 })

        expect(thing).to_not be_valid
        expect(thing.errors.messages).to eq({:units_values=>["Units can not be zero"]})
      end
    end

    context "The unit is not a Hash" do
      it "Should be invalid" do
        thing = build(:thing, units: 2)

        expect(thing).to_not be_valid
        expect(thing.errors.messages).to eq({:units=>["Units must be a Hash"]})
      end
    end
  end
end
