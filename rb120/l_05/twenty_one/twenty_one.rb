require 'pry'
require 'yaml'
MSG = YAML.load_file("input.yml")

# Generic Displayable module for message printing
module Displayable
  PRINT_SPEED = 0.04
  QUICK_PAUSE = 0.8
  LONG_PAUSE = 2.0
  ELIPSIS_TIME = 0.5

  PAUSE_CHARS = %w(. ! ? : \))

  def clear_screen
    system 'clear'
  end

  def anim_print(msg)
    chars = msg.chars
    chars.each do |char|
      print char
      if PAUSE_CHARS.include?(char)
        sleep(QUICK_PAUSE)
      else
        sleep(PRINT_SPEED)
      end
    end
  end

  def anim_puts(msg)
    anim_print(msg)
    blank_line
  end

  def pause_print(msg)
    print msg
    sleep(LONG_PAUSE)
  end

  def pause_puts(msg)
    pause_print(msg)
    blank_line
  end

  def blank_line
    puts ""
  end

  def puts_with_elipsis(msg)
    print msg
    elipsis
    blank_line
  end

  def elipsis(time = ELIPSIS_TIME)
    sleep(time)
    3.times do
      print "."
      sleep(time)
    end
  end
end

# Twenty-One specific message printer
module TODisplayable
  include Displayable

  def display_hands
    clear_screen
    display_scores
    display_participant_hand(player)
    display_participant_hand(dealer)
  end

  def display_scores
    puts "#{player}'s score: #{player.score} || " \
         "#{dealer}'s score: #{dealer.score}"
  end

  def display_participant_hand(participant)
    blank_line
    print "#{participant}'s Hand: "
    participant.show_cards
    print "Hand Total: "
    puts participant.total
    blank_line
  end

  def display_hit
    anim_print "Hitting"
    elipsis
  end

  def display_stay(participant)
    anim_puts "#{participant} is staying with #{participant.total}."
    display_continue
  end

  def display_continue
    anim_print "Continuing"
    elipsis
  end

  def display_bust(participant)
    anim_puts "Oh no! #{participant} busted!"
    display_continue
  end

  def display_calculating
    anim_puts "Round over!"
    sleep(QUICK_PAUSE)
    anim_print "Calculating results"
    elipsis
    blank_line
  end

  def display_winner(winner)
    blank_line
    if winner.nil?
      anim_puts "It's a tie!"
    else
      anim_puts "#{winner} wins this round!"
    end
    display_continue
  end
end

# Refactored from TODisplay due to RuboCop
module KingDiceDialogue
  include Displayable
  # rubocop:disable Metrics/MethodLength
  def display_welcome
    clear_screen
    welcome = <<~WELCOME
      King Dice:
        Well look what the cat dragged in! Here to play a little 
        game of chance are we? It's a game of Twenty-One! But
        before we get into that
    WELCOME
    anim_print welcome
    blank_line
    elipsis
  end

  def display_goodbye
    clear_screen
    goodbye = <<~GOODBYE
      King Dice:
        Next time we won't take it so easy on ya!
        Until then...
    GOODBYE
    anim_print goodbye
  end

  def display_offer_rules
    clear_screen
    rules_offer = <<~RULES_OFFER
      King Dice:
         So you're #{player}, eh? Another soul ripe for the boss...
         I mean... friend! Yeah, friend! >) If ya've never played
         Twenty-One before, I can explain the rules for ya. If you have,
         we can get right into it. So what'll it be, kid?
    RULES_OFFER
    anim_print rules_offer
    blank_line
    elipsis
  end

  def display_rules
    clear_screen
    rules = <<~RULES
      King Dice:
        Awright, wheat! This is how it works. If ya've ever played
        Blackjack, it's a lot like that but without all the complicated
        rules. My dealer'll deal you cards as long as you want, but if
        ya go over 21, you BUST and YOU LOSE. Get as close to 21 as 
        you can without going over, if you're closer than them, you'll win
        a round. Best out of 5 rounds wins it all.
    RULES
    anim_print rules
  end

  def display_skip_rules
    clear_screen
    skip_rules = <<~SKIP_RULES
      King Dice:
        Awright, wheat! Right to it, then!
    SKIP_RULES
    anim_print skip_rules
  end

  def display_opponent
    blank_line
    anim_puts "Your dealer'll be #{dealer.full_name}!"
  end

  def display_get_ready
    anim_print "Press [Enter] if you dare! Ha ha ha!"
    gets.chomp
  end

  def display_player_win
    clear_screen
    player_win = <<~PLAYER_WIN
      King Dice:
        Well, lookee here! You actually pulled it off...
        but you made me lose a bet!! I'm not lettin' ya off that
        easy! But that's gonna have to wait until next time.
    PLAYER_WIN
    anim_puts player_win
  end

  def display_player_lose
    clear_screen
    player_lose = <<~PLAYER_LOSE
      King Dice:
        Ha ha ha! Looks like ya couldn't keep up, kid!
        Beter luck next time.
    PLAYER_LOSE
    anim_puts player_lose
  end
  # rubocop:enable Metrics/MethodLength
end

# Generic Input validator
module Inputtable
  include Displayable
  YES_OR_NO = %w(y n)

  def user_input(msg, condition, values=nil)
    input = ""
    loop do
      anim_puts msg
      print "> "
      input = gets.chomp
      break if valid_input(input, condition, values)
      display_error(condition)
    end
    blank_line
    input
  end

  private

  def display_error(condition)
    print MSG["input"]["invalid_input"]
    pause_puts error_message(condition)
  end

  def error_message(condition)
    MSG["input"][condition.to_s]
  end

  def valid_input(input, condition, values=nil)
    if condition == :non_empty
      non_empty?(input)
    elsif condition == :positive_numeric
      positive_numeric?(input)
    elsif condition == :values
      values?(input, values)
    elsif condition == :yes_or_no
      yes_or_no?(input)
    end
  end

  def non_empty?(input)
    return true unless empty_string?(input)
    false
  end

  def positive_numeric?(input)
    input_as_num = input.to_i
    return true if input_as_num.to_s == input && input_as_num > 0
    false
  end

  def values?(input, values)
    values = values.map(&:downcase)
    if valid_input(input, :non_empty)
      return true if values.include?(input.downcase)
    end
    false
  end

  def yes_or_no?(input)
    if valid_input(input, :non_empty)
      return true if YES_OR_NO.include?(input[0].downcase)
    end
    false
  end

  def empty_string?(str)
    str.empty? || str.chars.all? { |char| char == ' ' }
  end
end

# Generic Hand behavior, to be used in other Card Games
module Hand
  def add_card(card, face_up: true)
    card.flip! if !face_up
    cards << card
  end

  def show_cards
    str = "|| "
    cards_added = 0
    cards.each do |card|
      str << "\n|| " if cards_added % 4 == 0 && !cards_added.zero?
      str << "#{card} || "
      cards_added += 1
    end
    puts str
  end

  def reveal_cards
    cards.each do |card|
      card.flip! if card.face_down?
    end
  end

  def any_face_down?
    return true if cards.any?(&:face_down?)
  end

  def total; end
end

# Behavior specific to a Twenty-One Hand
module TOHand
  include Hand

  ACE_VALUES = [1, 11]
  ACE_DIFF = ACE_VALUES.max - ACE_VALUES.min
  COURT_VALUE = 10
  HAND_MAX = 21

  def total
    return "??" if any_face_down?
    total = raw_total
    num_aces = cards.select(&:ace?).count
    num_aces.times { total -= ACE_DIFF if total > HAND_MAX }

    total
  end

  def busted?
    total > HAND_MAX
  end

  # Only way I could think to get this method 10 lines or below
  # was by declaring the initial total in parameters
  # or by doing multiple inline if statements
  def raw_total(total=0)
    cards.each do |card|
      total += if card.ace?
                 ACE_VALUES.max
               elsif card.court?
                 COURT_VALUE
               else
                 card.value.to_i
               end
    end
    total
  end
end

module CardHolder
  # Generic Card Holder
  class Participant
    attr_reader :cards, :score

    def initialize
      @cards = []
      @score = 0
      set_name
    end

    def set_name
      @name = self.class.to_s
    end

    def to_s
      @name
    end

    def reset
      @cards = []
      @score = 0
    end

    def discard_hand
      @cards = []
    end

    def add_score(score_to_add=1)
      @score += score_to_add
    end

    def >; end
  end

  # Behvaior specific to Twenty-One
  class TOParticipant < Participant
    include TOHand

    VALID_MOVES = %w(h s hit stay)
    STAY_CHAR = VALID_MOVES[1]
    HIT_CHAR = VALID_MOVES[0]
    DEALER_MAX = 17

    def >(other_participant)
      if busted?
        false
      elsif other_participant.busted?
        true
      else
        total > other_participant.total
      end
    end
  end

  # Player/Dealer specific Behavior
  class Player < TOParticipant
    include Inputtable

    def set_name
      @name = user_input("Whata'ya call yourself, kid?", :non_empty)
    end

    def take_turn
      user_input("Ya gonna [H]it or [S]tay?",
                 :values, VALID_MOVES)
    end
  end

  class Dealer < TOParticipant
    def initialize
      super
      set_title
    end

    def set_name
      @name = ['Hilda Berg', 'Grim Matchstic', 'Pirouletta',
               'Wally Warbles', 'Cala Maria', 'Mr Wheezy'].sample
    end

    def set_title
      @title = case @name
               when 'Hilda Berg' then "Threatenin' Zepplin"
               when 'Grim Matchstic' then "Frollic'n Dragon"
               when 'Pirouletta' then "Dancin' Devil's Wheel"
               when 'Wally Warbles' then "Cuckoo Armored Avian"
               when 'Cala Maria' then "Mermaid Medusa"
               when 'Mr Wheezy' then "King's Cigar"
               end
    end

    def full_name
      "#{@name} the #{@title}"
    end

    def take_turn
      return STAY_CHAR if total >= DEALER_MAX
      HIT_CHAR
    end
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def shuffle_cards!
    cards.shuffle!
  end

  def deal_card
    cards.shift
  end
end

class Card
  SUITS = %w(S H D C)
  VALUES = %w(A 2 3 4 5 6 7 8 9 10 J Q K)

  attr_reader :face_up

  def initialize(suit, value)
    @suit = suit
    @value = value
    @face_up = true
  end

  def to_s
    if face_up
      "#{value} of #{suit}"
    else
      "?? of ????"
    end
  end

  def flip!
    self.face_up = !face_up
  end

  def face_down?
    !face_up
  end

  def ace?
    value == 'Ace'
  end

  def jack?
    value == 'Jack'
  end

  def queen?
    value == 'Queen'
  end

  def king?
    value == 'King'
  end

  def court?
    jack? || queen? || king?
  end

  def suit
    case @suit
    when 'S' then 'Spades'
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'C' then 'Clubs'
    end
  end

  def value
    case @value
    when 'A' then 'Ace'
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    else @value
    end
  end

  private

  attr_writer :face_up
end

class Game
  include Inputtable
  include TODisplayable
  include KingDiceDialogue

  WINNING_SCORE = 3

  attr_accessor :deck, :player, :dealer

  def initialize
    clear_screen
    @deck = nil
    @player = nil
    @dealer = nil
  end

  def start
    display_welcome
    setup_game
    rules
    main_game
    display_goodbye
  end

  private

  def setup_game
    self.deck = Deck.new
    deck.shuffle_cards!
    player.nil? ? self.player = CardHolder::Player.new : player.reset
    self.dealer = CardHolder::Dealer.new
  end

  def reset_round
    self.deck = Deck.new
    deck.shuffle_cards!
    player.discard_hand
    dealer.discard_hand
  end

  def rules
    display_offer_rules
    rules? ? display_rules : display_skip_rules
  end

  def pre_game
    display_opponent
    display_get_ready
  end

  def play_match
    loop do
      deal_starting_hands
      display_hands
      participant_turn(player)
      participant_turn(dealer) if !player.busted?
      dealer.reveal_cards
      finish_round
      break if match_winner?
      reset_round
    end
  end

  def main_game
    loop do
      pre_game
      play_match
      finish_match
      break unless play_again?
      setup_game
    end
  end

  def rules?
    choice = user_input("Need me to explain the rules?", :yes_or_no)
    choice[0] == 'y'
  end

  def deal_starting_hands
    # places Dealer's first card face down
    2.times do |time|
      player.add_card(deck.deal_card)
      show_cards_and_pause
      dealer_face_up = !(time == 0)
      dealer.add_card(deck.deal_card, face_up: dealer_face_up)
      show_cards_and_pause
    end
  end

  def show_cards_and_pause
    display_hands
    sleep(LONG_PAUSE)
  end

  def participant_turn(participant)
    participant.reveal_cards
    loop do
      display_hands
      break if busting?(participant)
      choice = participant.take_turn
      break if staying?(participant, choice)
      handle_hit(participant)
    end
  end

  def staying?(participant, choice)
    if choice.start_with?(CardHolder::TOParticipant::STAY_CHAR)
      handle_stay(participant)
      return true
    end
    false
  end

  def busting?(participant)
    if participant.busted?
      handle_bust(participant)
      return true
    end
    false
  end

  def handle_hit(participant)
    display_hit
    participant.add_card(deck.deal_card)
  end

  def handle_stay(participant)
    display_stay(participant)
  end

  def handle_bust(participant)
    display_bust(participant)
  end

  def finish_round
    display_hands
    display_calculating
    winner = determine_round_winner
    handle_round_winner(winner)
  end

  def handle_round_winner(winner)
    display_winner(winner)
    winner&.add_score
  end

  def determine_round_winner
    if player > dealer
      player
    elsif dealer > player
      dealer
    end
  end

  def finish_match
    if player.score == WINNING_SCORE
      display_player_win
    elsif dealer.score == WINNING_SCORE
      display_player_lose
    end
  end

  def match_winner?
    player.score == WINNING_SCORE || dealer.score == WINNING_SCORE
  end

  def play_again?
    choice = user_input("Ya wanna play again?", :yes_or_no)
    choice[0] == 'y'
  end
end

Game.new.start
