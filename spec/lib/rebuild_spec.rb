require './lib/rebuild.rb'

RSpec.describe Rebuild do
  let(:subject) { described_class }
  let(:messages)  { ["1ascd", "20000", "5aedf", "8adfd"] }

  describe "#messages_array" do
    it "Should return new array rebuild" do
      response = subject.messages_array(messages)
      expected_response = ["5aedf", "8adfd", "20000ascd"]

      expect(response).to eq(expected_response)
    end
  end

  describe "#join_accumulator_messages" do
    it "Should return a string joined with the accumulator messages" do
      response = subject.join_accumulator_messages(messages[0..1])
      expected_response = "20000ascd"

      expect(response).to eq(expected_response)
    end
  end
end
