require 'spec_helper'

describe Snapme::Snapper do
  let(:host)    { 'http://example.com' }
  let(:interval){ double :interval     }
  let(:command) { double :command      }

  subject(:snapper){ described_class.new(host, interval, command) }

  describe '#run' do
    it 'takes a snapshot' do
      expect(command).to receive(:call).with(snapper.filename)
      snapper.run(false) # do not loop
    end

    it 'posts the snapshot to the web' do
      allow(command).to receive(:call)
      curl = double 'Curl::Easy'
      file = double 'Curl::PostField'

      # Hint: The number of mocks here is probably a hint that we're missing an
      # object. I'm willing to accept this for now...
      expect(Curl::Easy).to receive(:new).with(snapper.endpoint_url).and_return(curl)
      expect(Curl::PostField).to receive(:file)
        .with(snapper.field_name, snapper.filename)
        .and_return(file)
      expect(curl).to receive(:multipart_form_post=).with(true)
      expect(curl).to receive(:http_post).with(file)

      snapper.run(false)
    end
  end
end
