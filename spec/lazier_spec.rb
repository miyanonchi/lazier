require 'spec_helper'

describe Lazier do
  it 'has a version number' do
    expect(Lazier::VERSION).not_to be nil
  end

  describe Lazier::Base do
    it 'has a configure method' do
      expect(Lazier::Base).to respond_to(:configure)
    end

    it 'must take a block argument' do
      # do configure with block
      expect{
        Lazier::Base.configure do |config|
          # something
        end
      }.not_to raise_error
    end
  end
end
