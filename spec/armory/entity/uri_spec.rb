# coding: utf-8
require 'helper'
require "addressable/uri"

describe Armory::URL do

  describe '#uri' do
    it 'returns a URI when the url is set' do
      url = Armory::URL.new(url: 'http://us.battle.net/auction-data/2313a3efb8e956d9ce3683b7c41fc16e/auctions.json')
      expect(url.url).to be_an Addressable::URI
      expect(url.url.to_s).to eq('http://us.battle.net/auction-data/2313a3efb8e956d9ce3683b7c41fc16e/auctions.json')
    end
    it 'returns nil when the url is not set' do
      url = Armory::URL.new
      expect(url.url).to be_nil
    end
  end

  describe '#url?' do
    it 'returns true when the url is set' do
      url = Armory::URL.new(url: 'http://us.battle.net/auction-data/2313a3efb8e956d9ce3683b7c41fc16e/auctions.json')
      expect(url.url?).to be true
    end
    it 'returns false when the url is not set' do
      url = Armory::URL.new
      expect(url.url?).to be false
    end
  end

end
