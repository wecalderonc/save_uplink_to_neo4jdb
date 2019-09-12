require './config/application.rb'

RSpec.describe Things::Uplinks::Get do
  describe '#call' do
    let(:response) { subject.(input) }

    context 'thing has uplinks' do
      let(:uplink) { create(:uplink) }
      let(:input) { { thing: uplink.thing } }

      it 'should return success response' do

        expect(response).to be_success
      end
    end

    context 'thing doesnt have uplinks' do
      let(:thing) { create(:thing) }
      let!(:input) { { thing: thing } }

      it 'should return failure response' do

        expect(response).to be_failure
        expect(response.failure[:error]).to eq('The thing does not have uplinks')
      end
    end
  end
end
