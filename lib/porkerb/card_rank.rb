module Porkerb
  class CardRank
    include Comparable

    @@priolity = {
      "A"  => 0,
      "K"  => 1,
      "Q"  => 2,
      "J"  => 3,
      "10" => 4,
      "9"  => 5,
      "8"  => 6,
      "7"  => 7,
      "6"  => 8,
      "5"  => 9,
      "4"  => 10,
      "3"  => 11,
      "2"  => 12
    }

    attr_reader :rank

    def initialize(rank)
      @rank = rank
    end

    def priolity
      @@priolity[rank]
    end

    def <=>(other)
      other.priolity <=> priolity
    end

    def to_s
      rank
    end
  end
end
