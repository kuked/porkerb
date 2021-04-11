$LOAD_PATH.unshift("#{__dir__}/../lib")
require "minitest/autorun"
require "porkerb"

class TestHand < Minitest::Test
  include Porkerb

  def setup
    @pair_of_ace = Hand.new([Card.new("S", "A"), Card.new("H", "A")])
    @flush_of_clover = Hand.new([Card.new("C", "2"), Card.new("C", "4")])
    @highcard = Hand.new([Card.new("S", "A"), Card.new("C", "8")])
  end

  def test_pair?
    assert @pair_of_ace.pair?
    refute @flush_of_clover.pair?
  end

  def test_flash?
    assert @flush_of_clover.flush?
    refute @pair_of_ace.flush?
  end

  def test_highcard?
    assert @highcard.highcard?
    refute @pair_of_ace.highcard?
    refute @flush_of_clover.highcard?
  end
end
