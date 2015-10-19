
class Card

  attr_accessor :suit, :face, :value

  def initialize(face, suit)
    self.suit = suit
    self.face = face
    if face == "King" || face == "Queen" || face == "Jack"
      self.value = 10
    elsif face == "Ace"
        self.value = 11
    else
      self.value = face.to_i
    end
  end

  def > (card)
    self.value > card.value

  end

end
