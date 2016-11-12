require 'helper'

describe Armory::REST::Utils do

  class DummyClass
  end

  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Armory::REST::Utils)
  end

  describe '#extract_slug' do
    it "passes string back" do
      object = @dummy_class.extract_slug("realm-slug")
      expect(object).to be_a ::String
      expect(object).to eq("realm-slug")
    end
    it "converts Armory::BasicRealm to slug" do
      realm = Armory::BasicRealm.new('us', slug: 'realm1')
      object = @dummy_class.extract_slug(realm)
      expect(object).to be_a ::String
      expect(object).to eq("realm1")
    end
    it "converts Armory::Realm to slug" do
      realm = Armory::Realm.new('us', slug: 'realm1')
      object = @dummy_class.extract_slug(realm)
      expect(object).to be_a ::String
      expect(object).to eq("realm1")
    end
    it "generates error with array" do
      expect { 
        @dummy_class.extract_slug(["a","b","c"])
       }.to raise_exception(Armory::Error::InvalidRealm)
    end
  end

  describe '#extract_url' do
    it "returns valid URL as string" do
      object = @dummy_class.extract_url("http://blizzard.com/home")
      expect(object).to be_a ::String
      expect(object).to eq("http://blizzard.com/home")
    end
    it "returns Armory::Auction as string" do
      realm = Armory::Auction.new('us', files: [{ url: "http://blizzard.com/home2"}])
      object = @dummy_class.extract_url(realm)
      expect(object).to be_a ::String
      expect(object).to eq("http://blizzard.com/home2")
    end
    it "returns Addressable::URI as string" do
      realm = Addressable::URI.parse("http://blizzard.com/home3")
      object = @dummy_class.extract_url(realm)
      expect(object).to be_a ::String
      expect(object).to eq("http://blizzard.com/home3")
    end
  end

end
