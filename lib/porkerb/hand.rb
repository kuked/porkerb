require_relative "hand_rank"

module Porkerb
  class Hand
    include Comparable

    attr_reader :rank, :cards

    def initialize(cards)
      @cards = cards
      decide!
    end

    def cards
      @cards.sort.reverse
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
      card = cards.first
      cards.count { |c| c.same_rank? card } == 2 # include myself
    end

    def highcard?
      card = cards.first
      same_rank = cards.count { |c| c.same_rank? card } > 1 # include myself
      same_suit = cards.all? { |c| c.same_suit? card }
      !same_rank && !same_suit && !_straight?
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
        ace_low? ? cards.last.rank : cards.first.rank
      else
        cards
      end
    end

    def self.from(card_notations)
      Hand.new card_notations.map { |c| Card.from c }
    end

    private

    def _straight?
      sorted = cards.dup
      sorted.shift if ace_low?

      priolity = sorted.first.priolity
      expected = (priolity...priolity + sorted.length).to_a
      expected == sorted.map(&:priolity)
    end

    def _flush?
      card = cards.first
      cards.all? { |c| c.same_suit? card }
    end

    def decide!
      hand = if straightflush?
               :straight_flush
             elsif straight?
               :straight
             elsif flush?
               :flush
             elsif pair?
               :one_pair
             else
               :high_card
             end
      @rank = HandRank.new(hand)
    end

    def ace_low?
      cards.first.rank?("A") && cards.last.rank?("2")
    end
  end
end
