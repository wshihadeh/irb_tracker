require 'spec_helper'

class FakeIrb
  class FakeContext
    def evaluate(line, line_no)
      # NOOP
    end

    def inspect_last_value
      '4'
    end
  end
end

RSpec.describe IRBTracker::IRBLoggable do
  let(:logger) { instance_spy(Logger) }
  let(:irb_context) { FakeIrb::FakeContext.new }
  let(:arg) { '2 + 2' }

  before do
    allow(::LoggerFactory).to receive(:create).and_return(logger)
    FakeIrb::FakeContext.prepend(described_class.new(logger))
  end

  it 'logs command and result' do
    irb_context.evaluate(arg, 22)
    expect(logger).to have_received(:info).with(source: 'irb_console', command: arg, result: '4', user: nil)
  end
end
