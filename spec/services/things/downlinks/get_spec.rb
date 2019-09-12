require './config/application.rb'

RSpec.describe Things::Downlinks::Get do
  describe '#call' do
    let(:response) { subject.(input) }

    context 'thing has downlinks' do
      let(:thing) { create(:thing) }
      let(:input) { { thing: thing } }

      it 'should return success response' do

        expect(response).to be_success
      end
    end

    #TODO when last_downlinks exist
    # context 'thing doesnt have downlinks' do
    #   let(:thing) { create(:thing) }
    #   let!(:input) { { thing: thing } }

    #   it 'should return failure response' do

    #     expect(response).to be_failure
    #     expect(response.failure[:error]).to eq('The thing does not have downlinks')
    #   end
    # end
  end
end
