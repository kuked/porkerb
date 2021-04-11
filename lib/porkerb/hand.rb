module Porkerb
  class Hand
    def initialize(cards)
      @cards = cards
    end

    def pair?
      card = @cards.first
      @cards.all? { |c| c.same_rank? card }
    end

    def flush?
      card = @cards.first
      @cards.all? { |c| c.same_suit? card }
    end

    def highcard?
      card = @cards.first
      same_rank = @cards.all? { |c| c.same_rank? card }
      same_suit = @cards.all? { |c| c.same_suit? card }
      !same_rank && !same_suit
    end
  end
end
