require 'helper'

describe Armory::Base do
  describe ".new" do
    context 'when no region is provided' do
      it 'raises a RegionMissing exception' do
        expect { Armory::Base.new() }.to raise_exception(Armory::Error::RegionMissing)
      end
    end
    context 'when first paramter is not a string (region)' do
      it 'raises a RegionMissing exception' do
        expect { Armory::Base.new({id: 1}) }.to raise_exception(Armory::Error::RegionMissing)
      end
    end
  end

  describe "with valid constructor" do

    before do
      @base = Armory::Base.new("US", :id => 1)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@base.attrs).to eq(:id => 1)
      end
    end

    describe 'region' do
      it 'returns US' do
        expect(@base.region).to eq("US")
      end
    end

  end

end
