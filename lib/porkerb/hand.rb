require_relative "hand_rank"

module Porkerb
  class Hand
    include Comparable

    attr_reader :rank, :cards

    def initialize(cards)
      @cards = cards
      @group_by_rank = cards.group_by(&:priolity)
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

    def threecard?
      card = cards.first
      cards.count { |c| c.same_rank? card } == 3
    end

    def flush?
      !_straight? && _flush?
    end

    def two_pair?
      count_of_rank = @group_by_rank.values.map(&:count)
      count_of_rank.count { |i| i == 2 } == 2
    end

    def pair?
      count_of_rank = @group_by_rank.values.map(&:count)
      count_of_rank.count { |i| i == 2 } == 1
    end

    def highcard?
      same_rank = @group_by_rank.count != cards.count
      card = cards.first
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
             elsif threecard?
               :three_of_a_kind
             elsif two_pair?
               :two_pair?
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
