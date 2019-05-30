require './lib/rebuild.rb'

RSpec.describe Rebuild do
  let(:subject)   { described_class }
  let(:messages)  { ["1ascd", "20000", "5aedf", "8adfd"] }
  let(:messages2) { ["2aaaa", "8ffff", "1cccc", "3bbbb"] }
  let(:messages3) { ["3ascd", "40000", "5aedf", "8adfd"] }
  let(:messages4) { ["6dddd", "70000", "3aedf", "4adfd"] }


  describe "#messages_array" do
    it "Should return new array rebuild" do
      response = subject.messages_array(messages)
      expected_response = ["5aedf", "8adfd", "20000ascd"]

      expect(response).to eq(expected_response)
    end

    it "Should return new array rebuild" do
      response = subject.messages_array(messages2)
      expected_response = ["8ffff", "3bbbb", "2aaaacccc"]

      expect(response).to eq(expected_response)
    end

    it "Should return new array rebuild" do
      response = subject.messages_array(messages3)
      expected_response = messages3

      expect(response).to eq(expected_response)
    end

    it "Should return new array rebuild" do
      response = subject.messages_array(messages4)
      expected_response = messages4

      expect(response).to eq(expected_response)
    end
  end

  describe "#join_accumulator_messages" do
    it "Should return a string joined with the accumulator messages" do
      response = subject.join_accumulator_messages(messages[0..1])
      expected_response = "20000ascd"

      expect(response).to eq(expected_response)
    end

    it "Should return a string joined with the accumulator messages" do
      response = subject.join_accumulator_messages(messages2[0..1])
      expected_response = "8ffffaaaa"

      expect(response).to eq(expected_response)
    end

    it "Should return a string joined with the accumulator messages" do
      response = subject.join_accumulator_messages(messages3[0..1])
      expected_response = "40000ascd"

      expect(response).to eq(expected_response)
    end
  end
end
