require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize(deck = 1)
    self.cards= []
    number = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
    suits = %w[c d h s]
    number.each do |face|
      suits.each {|suit|
        card = Card.new(face, suit)
          self.cards << card
      }
    end
  end

  def shuffle
    self.cards.shuffle!
    #self.playing_deck << self.decks * self.cards.shuffle!
  end

  def draw
    self.cards.shift
    #self.playing_deck.shift
  end

  def empty?
    self.cards.empty?
  end

end
