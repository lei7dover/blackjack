require_relative 'deck'

class Game

  attr_accessor :deck, :dealer_hand, :player_hand, :dealer_wins, :player_wins

    def initialize
      self.deal
      self.player_wins = 0
      self.dealer_wins = 0
      #puts "Number of cards is #{deck.cards.length}"
    end

    def play
      puts "Let's play Blackjack!Press enter to play."
      response = STDIN.gets
      response = "Y"
      while response == "Y"
        player_hand=[]
        dealer_hand=[]
        self.hand
        self.inplay
        self.winner
        puts "Would you like to play again? (Y/N)"
        response = STDIN.gets.chomp
        if response == "Y"
          self.deal
        end
      end
      puts "Thanks for playing!"
    end

    def inplay
      response = nil
      if self.hand_value(dealer_hand) < 21
        while response != "Stay" && self.hand_value(player_hand) < 21 && self.hand_value(dealer_hand) < 16
          puts "Would you like to Hit or Stay?"
          response = STDIN.gets.chomp
            if response == "Hit"
              player_hand << deck.draw
              puts "Player's card is #{hand_output([player_hand[-1]])}"
              if hand_value(dealer_hand) < 16 && hand_value(player_hand) < 21
                dealer_hand << deck.draw
                puts "Dealer's card is #{hand_output([dealer_hand[-1]])}"
              end
            elsif response == "Stay"
              puts "#{hand_output(dealer_hand)} is Dealer hand #{hand_output(player_hand)} is the player hand."
              while self.hand_value(dealer_hand) < 16
                dealer_hand << deck.draw
              end
            end

          end
        end
    end


    def winner
      winner_is = ""
      if hand_value(player_hand) == 21
        winner_is = "Player"
      elsif hand_value(dealer_hand) == 21
        winner_is = "Dealer"
      elsif hand_value(player_hand) <21 && player_hand.length >= 6
        winner_is = "Player-- 6 or more cards"
      elsif hand_value(player_hand) > 21
        winner_is = "Dealer - you busted"
      elsif hand_value(dealer_hand) > 21
        winner_is = "Player - computer busted"
      elsif hand_value(player_hand) == hand_value(dealer_hand)
        if player_hand.length > dealer_hand.length
          winner_is = "Tie goes to Player & has more cards"
        else
          winner_is = "Tie goes to dealer & has more cards."
        end
      elsif hand_value(player_hand) > hand_value(dealer_hand)
        winner_is = "Player"
      else winner_is = "Dealer"
      end
      puts "The winner is #{winner_is}."
      puts "The dealer's hand is #{hand_output(dealer_hand)} and the player's hand is #{hand_output(player_hand)}"
      if winner_is.include? "Dealer"
        self.dealer_wins = self.dealer_wins + 1
      else
        self.player_wins = self.player_wins + 1
      end
      puts "Dealer won #{dealer_wins} & player won #{player_wins}"
    end

    def deal
      self.deck = Deck.new
      self.deck.shuffle
      self.dealer_hand = [self.deck.draw, self.deck.draw]
      self.player_hand = [self.deck.draw, self.deck.draw]
    end

    def dealer
      puts "#{dealer_hand[0].value} is the dealers 1st card.\n"
    end
    def player
      puts "#{player_hand[0].value} & #{player_hand[1].value} are the players cards.\n"
    end

    def hand_output(set_of_cards)
      hand_output = set_of_cards.collect do |card|
        "#{card.face} of #{card.suit}"
      end
      hand_output.join (" and ")
    end

    def hand
      dealer
      player
    end

    def hand_value(set_of_cards)
        set_of_cards.inject(0){|sum, card|
          sum = sum + card.value}
    end
end

Game.new.play
