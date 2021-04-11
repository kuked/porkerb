$LOAD_PATH.unshift("#{__dir__}/../lib")
require "minitest/autorun"
require "porkerb"

class TestCard < Minitest::Test
  include Porkerb

  def setup
    @three_of_spades = Card.new("S", "3")
    @jack_of_hearts = Card.new("H", "J")
  end

  def test_card_notation
    assert_equal "3S", @three_of_spades.notation
    assert_equal "JH", @jack_of_hearts.notation
  end
end
