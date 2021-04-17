$LOAD_PATH.unshift("#{__dir__}/../lib")
require "minitest/autorun"
require "porkerb"

class TestHand < Minitest::Test
  include Porkerb

  def setup
    @straightflush        = Hand.from(%w[DA DK DQ])
    @straight_of_ace_high = Hand.from(%w[DA SK CQ])
    @straight_of_ace_low  = Hand.from(%w[S3 H2 CA])
    @threecard            = Hand.from(%w[S6 D6 C6])
    @pair_of_ace          = Hand.from(%w[SA HA H6])
    @flush_of_clover      = Hand.from(%w[C2 C4 C9])
    @highcard             = Hand.from(%w[SA C8 S4])
  end

  def test_straightflush?
    assert @straightflush.straightflush?
    refute @straight_of_ace_low.straightflush?
    refute @straight_of_ace_high.straightflush?
    refute @flush_of_clover.straightflush?
    refute @threecard.straightflush?
    refute @pair_of_ace.highcard?
    refute @highcard.straightflush?
  end

  def test_straight?
    assert @straight_of_ace_high.straight?
    assert @straight_of_ace_low.straight?
    refute @pair_of_ace.straight?
    refute @flush_of_clover.straight?
    refute @threecard.straight?
    refute @highcard.straight?
    refute @straightflush.straight?
  end

  def test_threecard?
    assert @threecard.threecard?
    refute @straight_of_ace_high.threecard?
    refute @straight_of_ace_low.threecard?
    refute @pair_of_ace.threecard?
    refute @flush_of_clover.threecard?
    refute @highcard.threecard?
    refute @straightflush.threecard?
  end

  def test_pair?
    assert @pair_of_ace.pair?
    refute @threecard.pair?
    refute @flush_of_clover.pair?
    refute @highcard.pair?
    refute @straightflush.pair?
    refute @straight_of_ace_low.pair?
    refute @straight_of_ace_high.pair?
  end

  def test_flash?
    assert @flush_of_clover.flush?
    refute @threecard.flush?
    refute @straightflush.flush?
    refute @straight_of_ace_low.flush?
    refute @straight_of_ace_high.flush?
    refute @pair_of_ace.flush?
    refute @highcard.flush?
  end

  def test_highcard?
    assert @highcard.highcard?
    refute @straightflush.highcard?
    refute @straight_of_ace_low.highcard?
    refute @straight_of_ace_high.highcard?
    refute @pair_of_ace.highcard?
    refute @flush_of_clover.highcard?
    refute @threecard.highcard?
  end

  def test_comparable
    assert @straight_of_ace_high < @straightflush
    assert @flush_of_clover < @straight_of_ace_high
    assert @threecard < @flush_of_clover
    assert @pair_of_ace < @threecard
    assert @highcard < @pair_of_ace
  end

  def test_comparable_straight_flush
    straight_flush_H_32A = Hand.from(%w[H3 H2 HA])
    straight_flush_C_AKQ = Hand.from(%w[CA CK CQ])
    straight_flush_S_345 = Hand.from(%w[S3 S4 S5])

    assert @straightflush > straight_flush_H_32A
    assert @straightflush == straight_flush_C_AKQ
    assert straight_flush_H_32A < straight_flush_S_345
  end

  def test_comparable_straight
    straight_C2_SA = Hand.from(%w[D3 C2 SA])
    straight_H3_D4 = Hand.from(%w[H3 D4 C5])

    assert @straight_of_ace_high > @straight_of_ace_low
    assert @straight_of_ace_low == straight_C2_SA
    assert @straight_of_ace_low < straight_H3_D4
  end

  def test_comparable_flush
    flush_of_heart_1 = Hand.from(%w[H8 H3 H10])
    flush_of_heart_2 = Hand.from(%w[H2 H4 H9])

    assert @flush_of_clover < flush_of_heart_1
    assert @flush_of_clover == flush_of_heart_2
  end

  def test_comparable_threecard
    threecard_1 = Hand.from(%w[H7, C7, D7])
    threecard_2 = Hand.from(%w[H7, C7, D7])

    assert @threecard < threecard_1
    assert threecard_1 == threecard_2
  end

  def test_comparable_one_pair
    pair_of_king_1 = Hand.from(%w[SK CK D6])
    pair_of_king_2 = Hand.from(%w[HK DK C6])

    assert pair_of_king_1 < @pair_of_ace
    assert pair_of_king_1 == pair_of_king_2
  end

  def test_comparable_high_card
    high_card_1 = Hand.from(%w[SK CJ H9])
    high_card_2 = Hand.from(%w[HA C4 D8])

    assert @highcard > high_card_1
    assert @highcard == high_card_2
  end
end
