module Porkerb
  class Hand
    def initialize(cards)
      @cards = cards
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

    private

    def _straight?
      sorted = @cards.sort_by(&:rank)
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
  end
end
