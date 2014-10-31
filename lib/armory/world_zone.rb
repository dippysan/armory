module Armory
  class WorldZone < Armory::MetaMethods

    # :wintergrasp=>{
    #    :area=>1,
    #    :"controlling-faction"=>0,
    #    :status=>0,
    #    :next=>1414569632644},
    # :"tol-barad"=>{
    #    :area=>21,
    #    :"controlling-faction"=>0,
    #    :status=>0,
    #    :next=>1414568667783},

    # @return [Integer]
    attr_reader :area, :status, :next
    

    def controllingfaction
        @attr[:'controlling-faction']
    end
    alias_method :controlling_faction, :'controllingfaction'

  end
end
