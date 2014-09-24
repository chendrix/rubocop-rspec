# encoding: utf-8

require 'spec_helper'

describe RuboCop::Cop::RSpec::ExplicitPredicateMethod, :config do
  subject(:cop) { described_class.new(config) }
  let(:cop_config) do
    {
      'IgnoredMethods' => []
    }
  end

  it 'checks methods that begin with be_' do
    inspect_source(cop, ['expect(blah).to be_successful'])
    expect(cop.offenses.size).to eq(1)
    expect(cop.offenses.map(&:line).sort).to eq([1])
    expect(cop.messages).to eq(['Prefer use of explicit predicate method tests'])
  end

  context 'when you configure the IgnoredMethods to include something found' do
    let(:cop_config) do
      {
        'IgnoredMethods' => %w(be_empty)
      }
    end

    it 'does not add an offense when it is found' do
      inspect_source(cop, ['expect([]).to be_empty'])
      expect(cop.offenses.size).to eq(0)
    end
  end
end
