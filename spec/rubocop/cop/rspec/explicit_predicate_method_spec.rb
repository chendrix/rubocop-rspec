# encoding: utf-8

require 'spec_helper'

describe RuboCop::Cop::RSpec::ExplicitPredicateMethod do
  subject(:cop) { described_class.new }

  it 'checks methods that begin with be_' do
    inspect_source(cop, ['expect(blah).to be_successful'])
    expect(cop.offenses.size).to eq(1)
    expect(cop.offenses.map(&:line).sort).to eq([1])
    expect(cop.messages).to eq(['Prefer use of explicit predicate method tests'])
  end

  it 'does not match be_a' do
    inspect_source(cop, ['expect(blah).to be_a String'])
    expect(cop.offenses.size).to eq(0)
  end

  it 'does not match be_empty' do
    inspect_source(cop, ['expect([]).to be_empty'])
    expect(cop.offenses.size).to eq(0)
  end
end
