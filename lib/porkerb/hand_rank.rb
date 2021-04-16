module Porkerb
  class HandRank
    include Comparable

    @@priority = {
      :straight_flush => 0,
      :straight       => 1,
      :flush          => 2,
      :one_pair       => 3,
      :high_card      => 4
    }

    attr_reader :hand

    def initialize(hand)
      @hand = hand
    end

    def priolity
      @@priority[hand]
    end

    def <=>(other)
      other.priolity <=> priolity
    end

    def to_s
      hand
    end
  end
end
