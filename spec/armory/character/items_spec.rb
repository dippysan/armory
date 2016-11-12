# coding: utf-8
require 'helper'

describe Armory::Character::Items do

  describe "all items present" do

    before do
      @data = {
          averageItemLevel: 626,
          averageItemLevelEquipped: 610,
          head: {
              id: 118941,
              name: "Crown of Woe",
              icon: "inv_crown_02",
              quality: 4,
              itemLevel: 640,
              tooltipParams: {},
              stats: [{
                  stat: 51,
                  amount: 63
              }],
              armor: 114,
              context: "dungeon-heroic",
              bonusLists: []
          },
          neck:     {id: 109952, },
          shoulder: {id: 109938, },
          back:     {id: 109905, },
          chest:    {id: 115122, },
          shirt:    {id: 98093, },
          wrist:    {id: 115088, },
          hands:    {id: 109851, },
          waist:    {id: 109842, },
          legs:     {id: 109811, },
          feet:     {id: 109787, },
          finger1:  {id: 109759, },
          finger2:  {id: 118292, },
          trinket1: {id: 118680, },
          trinket2: {id: 118246, },
          mainHand: {id: 120054, },
          offHand:  {id: 120055, },
          ranged:   {id: 120056, },
          tabard:   {id: 120057, }
      }
      @item = Armory::Character::Items.new(@data)
    end

    describe '#attrs' do
      it 'returns a hash of attributes' do
        expect(@item.attrs).to eq(@data)
      end
    end

    describe '#new' do
      it 'returns Armory::Character::Items with the correct data' do
        expect(@item).to be_a Armory::Character::Items
        expect(@item.average_item_level).to be_a Integer
        expect(@item.average_item_level).to eq(626)
        expect(@item.average_item_level_equipped).to be_a Integer
        expect(@item.average_item_level_equipped).to eq(610)
        expect(@item.average_item_level_equipped).to be_a Integer
        expect(@item.average_item_level_equipped).to eq(610)
      end
      
      it 'returns each item as Armory::Character::Item' do
        expect(@item.head).to be_a Armory::Item
        expect(@item.head.id).to eq(118941)
        expect(@item.neck).to be_a Armory::Item
        expect(@item.neck.id).to eq(109952)
        expect(@item.shoulder).to be_a Armory::Item
        expect(@item.shoulder.id).to eq(109938)
        expect(@item.back).to be_a Armory::Item
        expect(@item.back.id).to eq(109905)
        expect(@item.chest).to be_a Armory::Item
        expect(@item.chest.id).to eq(115122)
        expect(@item.shirt).to be_a Armory::Item
        expect(@item.shirt.id).to eq(98093)
        expect(@item.wrist).to be_a Armory::Item
        expect(@item.wrist.id).to eq(115088)
        expect(@item.hands).to be_a Armory::Item
        expect(@item.hands.id).to eq(109851)
        expect(@item.waist).to be_a Armory::Item
        expect(@item.waist.id).to eq(109842)
        expect(@item.legs).to be_a Armory::Item
        expect(@item.legs.id).to eq(109811)
        expect(@item.feet).to be_a Armory::Item
        expect(@item.feet.id).to eq(109787)
        expect(@item.finger1).to be_a Armory::Item
        expect(@item.finger1.id).to eq(109759)
        expect(@item.finger2).to be_a Armory::Item
        expect(@item.finger2.id).to eq(118292)
        expect(@item.trinket1).to be_a Armory::Item
        expect(@item.trinket1.id).to eq(118680)
        expect(@item.trinket2).to be_a Armory::Item
        expect(@item.trinket2.id).to eq(118246)
        expect(@item.main_hand).to be_a Armory::Item
        expect(@item.main_hand.id).to eq(120054)
        expect(@item.off_hand).to be_a Armory::Item
        expect(@item.off_hand.id).to eq(120055)
        expect(@item.ranged).to be_a Armory::Item
        expect(@item.ranged.id).to eq(120056)
        expect(@item.tabard).to be_a Armory::Item
        expect(@item.tabard.id).to eq(120057)
      end

      it 'returns all data for head' do
        head = @item.head
        expect(head).to be_a Armory::Item
        expect(head.id).to eq(118941)
        expect(head.name).to be_a String
        expect(head.name).to eq("Crown of Woe")
        expect(head.icon).to be_a String
        expect(head.icon).to eq("inv_crown_02")
        expect(head.quality).to be_a Integer
        expect(head.quality).to eq(4)
        expect(head.item_level).to be_a Integer
        expect(head.item_level).to eq(640)
        expect(head.tooltip_params).to be_a Armory::Item::Extra
        expect(head.stats).to be_a Array
        expect(head.stats.first).to be_a Armory::Item::Stat
        expect(head.stats.first.stat).to be_a Integer
        expect(head.stats.first.stat).to eq(51)
        expect(head.stats.first.amount).to be_a Integer
        expect(head.stats.first.amount).to eq(63)
        expect(head.armor).to be_a Integer
        expect(head.armor).to eq(114)
        expect(head.context).to be_a String
        expect(head.context).to eq("dungeon-heroic")
        expect(head.bonus_lists).to be_a Array
        expect(head.bonus_lists).to eq([])
      end

    end

    describe '#slots' do
      it 'inserts correct slot numbers into items' do
        expect(@item.head.slot).to      eq(0)
        expect(@item.neck.slot).to      eq(1)
        expect(@item.shoulder.slot).to  eq(2)
        expect(@item.back.slot).to      eq(14)
        expect(@item.chest.slot).to     eq(4)
        expect(@item.shirt.slot).to     eq(3)
        expect(@item.wrist.slot).to     eq(8)
        expect(@item.hands.slot).to     eq(9)
        expect(@item.waist.slot).to     eq(5)
        expect(@item.legs.slot).to      eq(6)
        expect(@item.feet.slot).to      eq(7)
        expect(@item.finger1.slot).to   eq(10)
        expect(@item.finger2.slot).to   eq(11)
        expect(@item.trinket1.slot).to  eq(12)
        expect(@item.trinket2.slot).to  eq(13)
        expect(@item.main_hand.slot).to eq(15)
        expect(@item.off_hand.slot).to  eq(16)
        expect(@item.ranged.slot).to    eq(17)
        expect(@item.tabard.slot).to    eq(18)
      end

      it 'exposes slots array' do
        expect(@item.slots[0]).to   eq(@item.head)
        expect(@item.slots[1]).to   eq(@item.neck)
        expect(@item.slots[2]).to   eq(@item.shoulder)
        expect(@item.slots[14]).to  eq(@item.back)
        expect(@item.slots[4]).to   eq(@item.chest)
        expect(@item.slots[3]).to   eq(@item.shirt)
        expect(@item.slots[8]).to   eq(@item.wrist)
        expect(@item.slots[9]).to   eq(@item.hands)
        expect(@item.slots[5]).to   eq(@item.waist)
        expect(@item.slots[6]).to   eq(@item.legs)
        expect(@item.slots[7]).to   eq(@item.feet)
        expect(@item.slots[10]).to  eq(@item.finger1)
        expect(@item.slots[11]).to  eq(@item.finger2)
        expect(@item.slots[12]).to  eq(@item.trinket1)
        expect(@item.slots[13]).to  eq(@item.trinket2)
        expect(@item.slots[15]).to  eq(@item.main_hand)
        expect(@item.slots[16]).to  eq(@item.off_hand)
        expect(@item.slots[17]).to  eq(@item.ranged)
        expect(@item.slots[18]).to  eq(@item.tabard)
      end

      it 'enumerates items' do
        @item.each.with_index do |slot, i|
          expect(slot).to   eq(@item.slots[i])
        end
      end

    end
  end

  describe "some items missing" do

    before do
      @data = {
          averageItemLevel: 626,
          averageItemLevelEquipped: 610,
          head:     { id: 118941 },
          neck:     {id: 109952, },
          shoulder: {id: 109938, },
          back:     {id: 109905, },
          chest:    {id: 115122, }
      }
      @item = Armory::Character::Items.new(@data)
    end

    describe '#new' do
      it 'returns nil for slots not equipped' do
        expect(@item.head.id).to eq(118941)
        expect(@item.feet).to eq(nil)
        expect(@item.finger1).to eq(nil)
        expect(@item.trinket1).to eq(nil)
      end

      it 'enumerates items' do
        @item.each.with_index do |slot, i|
          expect(slot).to   eq(@item.slots[i])
        end
      end

    end
  end  


end


