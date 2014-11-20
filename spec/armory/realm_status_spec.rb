# coding: utf-8
require 'helper'

describe Armory::RealmStatus do

  before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe '#realms' do
    before do
      realms_array = [
        {
          :name => 'Ravencrest',
          :slug => 'ravencrest',
        },
      ]
      @realms = Armory::RealmStatus.new('US', :realms => realms_array)
      @realms = @realms.realms
    end

    it 'returns an array of Armory::Realm when realms are set' do
      expect(@realms).to be_an Array
      expect(@realms.first).to be_a Armory::Realm
      expect(@realms.first.name).to eq("Ravencrest")
      expect(@realms.first.slug).to eq("ravencrest")
    end
    it 'is empty when not set' do
      realms = Armory::RealmStatus.new('US').realms
      expect(realms).to be_empty
    end
  end

  describe '#each' do
    before do
      @realm_results = Armory::RealmStatus.new("US", :realms => [{slug: "r1"}, {slug: "r2"}, {slug: "r3"}, {slug: "r4"}, {slug: "r5"}, {slug: "r6"}])
    end
    it 'has count' do
      expect(@realm_results.count).to eq(6)
    end
    it 'iterates' do
      count = 0
      @realm_results.each { count += 1 }
      expect(count).to eq(6)
    end
    context 'with start' do
      it 'iterates' do
        count = 0
        @realm_results.each(5) { count += 1 }
        expect(count).to eq(1)
      end
    end
  end

end
