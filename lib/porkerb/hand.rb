require_relative "hand_rank"

module Porkerb
  class Hand
    include Comparable

    attr_reader :rank

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

    def <=>(other)
      if @rank == other.rank
        max_rank <=> other.max_rank
      else
        @rank <=> other.rank
      end
    end

    def max_rank
      if straightflush? || straight?
        sorted = @cards.sort.reverse
        ace_to_five? ? sorted.last.rank : sorted.first.rank
      elsif pair?
        @cards.first.rank
      end
    end

    def self.from(card_notations)
      cards = card_notations.map { |c| Card.from c }
      Hand.new cards
    end

    private

    def _straight?
      sorted = @cards.sort.reverse
      sorted.shift if ace_to_five?

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

    def ace_to_five?
      sorted = @cards.sort.reverse
      sorted.first.rank?("A") && sorted.last.rank?("2")
    end
  end
end
