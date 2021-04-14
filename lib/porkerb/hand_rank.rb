module Porkerb
  class HandRank
    include Comparable

    @@priority = {
      "straight flush" => 0,
      "straight"       => 1,
      "flush"          => 2,
      "one pair"       => 3,
      "high card"      => 4
    }

    attr_reader :rank

    def initialize(rank)
      @rank = rank
    end

    def priolity
      @@priority[rank]
    end

    def <=>(other)
      other.priolity <=> priolity
    end

    def to_s
      rank
    end
  end
end
