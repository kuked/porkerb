require_relative "hand_rank"

module Porkerb
  class Hand
    def initialize(cards)
      @cards = cards
      @rank = HandRank.new(decide)
    end

    def straightflush?
      _straight? && _flush?
    end

    def straight?
      _straight? && !_flush?
    end

    def flush?
      !_straight? && _flush?
    end

    def pair?
      card = @cards.first
      @cards.all? { |c| c.same_rank? card }
    end

    def highcard?
      card = @cards.first
      same_rank = @cards.all? { |c| c.same_rank? card }
      same_suit = @cards.all? { |c| c.same_suit? card }
      !same_rank && !same_suit
    end

    def self.from(card_notations)
      cards = card_notations.map { |c| Card.from c }
      Hand.new cards
    end

    private

    def _straight?
      sorted = @cards.sort
      if sorted.first.rank?("A") && sorted.last.rank?("2")
        sorted.shift
      end

      priolity = sorted.first.priolity
      expected = (priolity...priolity + sorted.length).to_a

      expected == sorted.map(&:priolity)
    end

    def _flush?
      card = @cards.first
      @cards.all? { |c| c.same_suit? card }
    end

    def decide
      return "straight flush" if straightflush?
      return "straight"       if straight?
      return "flush"          if flush?
      return "one pair"       if pair?
      return "high card"
    end
  end
end
