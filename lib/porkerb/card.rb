require_relative "card_rank"

module Porkerb
  class Card
    include Comparable

    attr_reader :suit, :rank

    def initialize(suit, rank)
      @suit = suit
      @rank = CardRank.new(rank)
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
      self == other
    end

    def rank?(rank)
      @rank.rank == rank
    end

    def self.from(card_notation)
      regexp = /(?<suit>[SHCD])(?<rank>[AKQJ]|10|[2-9])/
      card_notation.match(regexp) { |m| Card.new(m[:suit], m[:rank]) }
    end

    def <=>(other)
      @rank <=> other.rank
    end
  end
end
