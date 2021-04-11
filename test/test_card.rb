$LOAD_PATH.unshift("#{__dir__}/../lib")
require "minitest/autorun"
require "porkerb"

class TestCard < Minitest::Test
  include Porkerb

  def setup
    @ace_of_spades = Card.new("S", "A")
    @three_of_spades = Card.new("S", "3")
    @ace_of_hearts = Card.new("H", "A")
    @jack_of_hearts = Card.new("H", "J")
  end

  def test_card_notation
    assert_equal "3S", @three_of_spades.notation
    assert_equal "JH", @jack_of_hearts.notation
  end

  def test_same_suit?
    assert @ace_of_spades.same_suit? @three_of_spades
    refute @ace_of_spades.same_suit? @ace_of_hearts
  end

  def test_has_same_rank?
    assert @ace_of_spades.same_rank? @ace_of_hearts
    refute @ace_of_spades.same_rank? @three_of_spades
  end
end
