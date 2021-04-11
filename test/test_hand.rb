$LOAD_PATH.unshift("#{__dir__}/../lib")
require "minitest/autorun"
require "porkerb"

class TestHand < Minitest::Test
  include Porkerb

  def setup
    @straightflush        = Hand.from(%w[DA DK])
    @straight_of_ace_high = Hand.from(%w[DA SK])
    @straight_of_ace_low  = Hand.from(%w[H2 CA])
    @pair_of_ace          = Hand.from(%w[SA HA])
    @flush_of_clover      = Hand.from(%w[C2 C4])
    @highcard             = Hand.from(%w[SA C8])
  end

  def test_straightflush?
    assert @straightflush.straightflush?
    refute @straight_of_ace_low.straightflush?
    refute @flush_of_clover.straightflush?
  end

  def test_straight?
    assert @straight_of_ace_high.straight?
    assert @straight_of_ace_low.straight?

    refute @pair_of_ace.straight?
    refute @flush_of_clover.straight?
    refute @highcard.straight?
    refute @straightflush.straight?
  end

  def test_pair?
    assert @pair_of_ace.pair?
    refute @flush_of_clover.pair?
  end

  def test_flash?
    assert @flush_of_clover.flush?
    refute @pair_of_ace.flush?
    refute @straightflush.flush?
  end

  def test_highcard?
    assert @highcard.highcard?
    refute @pair_of_ace.highcard?
    refute @flush_of_clover.highcard?
  end
end
