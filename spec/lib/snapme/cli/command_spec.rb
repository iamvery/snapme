require 'spec_helper'
require 'ostruct'

describe Snapme::CLI::Command do
  describe '.start' do
    let(:args)   { double :args                             }
    let(:options){ OpenStruct.new                           }
    let(:snapper){ double('Snapme::Snapper').as_null_object }

    before do
      Snapme::CLI::Options.stub(parse: options)
      Snapme::Snapper.stub(new: snapper)
    end

    it 'parses options from the arguments' do
      expect(Snapme::CLI::Options).to receive(:parse).with(args)
      described_class.start(args)
    end

    it 'daemonizes the process if option is true' do
      options.daemon = true
      expect(Process).to receive(:daemon).with(true)
      described_class.start(args)
    end

    it 'does not daemonize the process if option is false' do
      expect(Process).to_not receive(:daemon)
      described_class.start(args)
    end

    it 'runs a snapper' do
      host     = double :host
      interval = double :interval
      options.host     = host
      options.interval = interval
      snapper = double 'Snapme::Snapper'

      expect(Snapme::Snapper).to receive(:new).with(host, interval).and_return(snapper)
      expect(snapper).to receive(:run)

      described_class.start(args)
    end
  end
end