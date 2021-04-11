module Porkerb
  class Card
    attr_reader :suit, :rank

    def initialize(suit, rank)
      @suit = suit
      @rank = rank
    end

    def notation
      "#{@rank}#{@suit}"
    end

    def same_suit?(other)
      @suit == other.suit
    end

    def same_rank?(other)
      @rank == other.rank
    end
  end
end
