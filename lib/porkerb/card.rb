require_relative "rank"

module Porkerb
  class Card
    attr_reader :suit, :rank

    def initialize(suit, rank)
      @suit = suit
      @rank = Rank.new(rank)
    end

    def notation
      "#{@rank}#{@suit}"
    end

    def priolity
      @rank.priolity
    end

    def same_suit?(other)
      @suit == other.suit
    end

    def same_rank?(other)
      @rank == other.rank
    end

    def rank?(rank)
      @rank.rank == rank
    end
  end
end
