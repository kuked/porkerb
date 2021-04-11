module Porkerb
  class Card
    def initialize(suit, rank)
      @suit = suit
      @rank = rank
    end

    def notation
      "#{@rank}#{@suit}"
    end
  end
end
