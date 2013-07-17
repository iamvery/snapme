require 'spec_helper'

describe Snapme::Snapper do
  let(:host)    { 'http://example.com' }
  let(:interval){ double :interval     }
  let(:command) { double :command      }

  subject(:snapper){ described_class.new(host, interval, command) }

  describe '#run' do
    it 'takes a snapshot' do
      command.should_receive(:call).with(snapper.filename)
      snapper.run(false) # do not loop
    end

    it 'posts the snapshot to the web' do
      command.stub(:call)
      curl = double 'Curl::Easy'
      file = double 'Curl::PostField'

      # Hint: The number of mocks here is probably a hint that we're missing an
      # object. I'm willing to accept this for now...
      Curl::Easy.should_receive(:new).with(snapper.endpoint_url).and_return(curl)
      Curl::PostField
        .should_receive(:file)
        .with(snapper.field_name, snapper.filename)
        .and_return(file)
      curl.should_receive(:http_post).with(file)

      snapper.run(false)
    end
  end
end
