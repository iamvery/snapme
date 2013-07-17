require 'spec_helper'

describe Snapme::CLI::Options do
  describe 'default values' do
    subject(:options){ described_class.new }

    it 'set daemon to true' do
      expect(options.daemon).to be_true
    end

    it 'has default host' do
      expect(options.host).to eq(described_class::DEFAULT_HOST)
    end

    it 'has default interval' do
      expect(options.interval).to eq(described_class::DEFAULT_INTERVAL)
    end
  end

  describe 'intialization' do
    it 'sets daemon to truthy value' do
      options = described_class.new(daemon: 'something truthy')
      expect(options.daemon).to be_true
    end

    it 'sets the host' do
      host = double :host
      options = described_class.new(host: host)
      expect(options.host).to eq(host)
    end

    it 'sets the interval to integer value' do
      integer  = 123
      interval = "#{integer}abc"
      options = described_class.new(interval: interval)
      expect(options.interval).to eq(integer)
    end
  end

  describe '.parse' do
    it 'handles --host option' do
      host    = 'http://example.com'
      args    = %W(--host #{host})
      options = described_class.parse(args)

      expect(options.host).to eq(host)
    end

    it 'handles -H (host alias) option' do
      host    = 'http://example.com'
      args    = %W(-H #{host})
      options = described_class.parse(args)

      expect(options.host).to eq(host)
    end

    it 'handles --daemon option' do
      args    = %w(--daemon)
      options = described_class.parse(args)

      expect(options.daemon).to be_true
    end

    it 'handles --no-daemon option' do
      args    = %w(--no-daemon)
      options = described_class.parse(args)

      expect(options.daemon).to be_false
    end

    it 'handles -d (daemon alias) option' do
      args    = %w(-d)
      options = described_class.parse(args)

      expect(options.daemon).to be_true
    end

    it 'handles --interval option' do
      interval = 123
      args     = %W(--interval #{interval})
      options  = described_class.parse(args)

      expect(options.interval).to eq(interval)
    end

    it 'handles -i (interval alias) option' do
      interval = 123
      args     = %W(-i #{interval})
      options  = described_class.parse(args)

      expect(options.interval).to eq(interval)
    end
  end
end
