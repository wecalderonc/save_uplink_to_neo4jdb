require './config/application.rb'

RSpec.describe Things::Get do
  describe '#call' do
    let(:response) { subject.(input) }

    context 'thing exist' do
      let(:thing) { create(:thing) }
      let!(:input) { { thing_name: thing.name } }

      it 'should return success response' do

        expect(response).to be_success
      end
    end

    context 'thing does not exist' do
      let!(:input) { { thing_name: "thing_wrong" } }

      it 'should return failure response' do

        expect(response).to be_failure
        expect(response.failure[:error]).to eq('The thing thing_wrong does not exist')
      end
    end
  end
end
