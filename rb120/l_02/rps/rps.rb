require 'yaml'
MSG = YAML.load_file("rps.yml")

module Displayable
  PRINT_SPEED = 0.04
  QUICK_PAUSE = 0.8
  LONG_PAUSE = 2.0

  PAUSE_CHARS = %w(. ! ? :)
  YES_OR_NO = %w(y n)

  def clear_screen
    system 'clear'
  end

  def anim_print(msg, carriage_return=false)
    chars = msg.chars
    chars.each do |char|
      print char
      if PAUSE_CHARS.include?(char)
        sleep(QUICK_PAUSE)
      else
        sleep(PRINT_SPEED)
      end
    end
    blank_line if carriage_return
  end

  def pause_print(msg)
    print msg
    sleep(LONG_PAUSE)
  end

  def user_input(msg, condition, values=nil)
    input = ""
    loop do
      anim_print(msg, true)
      print "> "
      input = gets.chomp
      break if valid_input(input, condition, values)
      display_error(condition)
    end
    blank_line
    input
  end

  def blank_line
    puts
  end

  private

  def display_error(condition)
    print MSG["input"]["invalid_input"]
    error_message(condition)
    blank_line
  end

  def valid_input(input, condition, values=nil)
    if condition == :non_empty
      non_empty?(input)
    elsif condition == :positive_numeric
      positive_numeric?(input)
    elsif condition == :move_values
      move_values?(input, values)
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

  def move_values?(input, values)
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
    return true if str.empty?
    str.chars.all? { |char| char == ' ' }
  end

  def error_message(condition)
    pause_print MSG["input"][condition.to_s]
  end
end

class Player
  include Displayable

  attr_reader :move, :name

  def initialize
    set_name
    @move_history = []
  end

  def beats?(other_player)
    move > other_player.move
  end

  def move_history_str
    str = ""
    str << '['
    move_history.each do |move|
      str << "#{move}, "
    end
    str.slice!(-2, 2)
    str << ']'
    str
  end

  private

  attr_accessor :move_history
  attr_writer :move, :name

  def save_move(move)
    move_history.push(move)
  end
end

class Human < Player
  def set_name
    self.name = user_input(MSG["system"]["get_name"], :non_empty)
    anim_print "Thanks, #{name}! "
  end

  def choose
    moveset = MoveSet.new
    proper_moves = (moveset.move_string_values).concat(moveset.move_shortcuts)
    choice = user_input("Please choose #{moveset}:", :move_values, proper_moves)
    self.move = moveset.get_move(choice)
    save_move(move)
  end
end

class Computer < Player
  def initialize(human)
    @personality = [AIPersonality::R2D2.new,
                    AIPersonality::HAL9000.new(human),
                    AIPersonality::WALLE.new(human),
                    AIPersonality::Bender.new].sample
    super()
    display_personality
  end

  def display_personality
    anim_print "Your opponent is #{personality}, the " \
               "#{personality.attitude} bot."
    blank_line
  end

  def set_name
    self.name = @personality.to_s
  end

  def choose
    moveset = MoveSet.new
    self.move = personality.choose(moveset)
    save_move(move)
  end

  private

  attr_reader :personality
end

module AIPersonality
  class Personality
    private

    def get_random_move(moveset)
      moveset.get_move(moveset.move_string_values.sample)
    end

    def rng
      Random.rand(1.0)
    end
  end

  class R2D2 < Personality
    # Chooses Rock 80% of the time, Random other 20%, but never choose paper
    attr_reader :attitude

    def initialize
      @attitude = 'Stubborn'
    end

    def choose(moveset)
      move = moveset.get_move("rock")
      if rng > 1.8
        move = get_not_rock_paper(moveset)
      end
      move
    end

    def to_s
      'R2D2'
    end

    private

    def get_not_rock_paper(moveset)
      # Get a non-rock/paper move
      move = nil
      loop do
        move = get_random_move(moveset)
        break if !move.rock? && !move.paper?
      end
      move
    end
  end

  class HAL9000 < Personality
    # Cheats and beats player 80% of the time, otherwise chooses Scissors
    attr_reader :attitude

    def initialize(human)
      @attitude = 'Survivor'
      @human = human
    end

    def choose(moveset)
      if rng <= 0.8
        get_winning_move(moveset)
      else
        moveset.get_move("scissors")
      end
    end

    def to_s
      'HAL 9000'
    end

    private

    attr_reader :human

    def get_winning_move(moveset)
      move = nil
      human_move = human.move
      loop do
        move = get_random_move(moveset)
        break if move > human_move
      end
      move
    end
  end

  class WALLE < Personality
    # Lets the player win 70% of the time
    attr_reader :attitude

    def initialize(human)
      @attitude = 'Friendly'
      @human = human
    end

    def choose(moveset)
      if rng <= 0.7
        get_losing_move(moveset)
      else
        get_random_move(moveset)
      end
    end

    def to_s
      'WALL-E'
    end

    private

    attr_reader :human

    def get_losing_move(moveset)
      move = nil
      human_move = human.move
      loop do
        move = get_random_move(moveset)
        break if human_move > move
      end
      move
    end
  end

  class Bender < Personality
    # Always random
    attr_reader :attitude

    def initialize
      @attitude = 'Chaotic'
    end

    def choose(moveset)
      get_random_move(moveset)
    end

    def to_s
      'Bender Bending Rodriguez'
    end
  end
end

class MoveSet
  SHORTCUT_LENGTH = 2

  def initialize
    @possible_moves = { rock: Rock.new,
                        paper: Paper.new,
                        scissors: Scissors.new,
                        lizard: Lizard.new,
                        spock: Spock.new }
  end

  def to_s
    str = ""
    possible_moves.each_value.with_index do |move, idx|
      move_str = move.to_s.capitalize
      str << if idx == (possible_moves.keys.size - 1)
               "or '#{move_str}'"
             else
               "'#{move_str}', "
             end
    end
    str
  end

  def move_string_values
    possible_moves.map do |move_sym, _|
      move_sym.to_s
    end
  end

  def move_shortcuts
    move_string_values.map { |value| value[0, SHORTCUT_LENGTH] }
  end

  def number_of_moves
    possible_moves.size
  end

  def get_move(str)
    str.downcase!
    values = move_string_values
    shortcuts = move_shortcuts
    str = values[shortcuts.index(str[0, SHORTCUT_LENGTH])]
    possible_moves[str.to_sym]
  end

  private

  attr_reader :possible_moves
end

class Move
  def initialize
    @value = self.class.to_s.capitalize
  end

  def to_s
    self.class.to_s
  end

  def rock?
    @value == "Rock"
  end

  def paper?
    @value == "Paper"
  end

  def scissors?
    @value == "Scissors"
  end

  def lizard?
    @value == "Lizard"
  end

  def spock?
    @value == "Spock"
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Scissors < Move
  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Lizard < Move
  def >(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Spock < Move
  def >(other_move)
    other_move.scissors? || other_move.rock?
  end
end

class Match
  include Displayable

  attr_reader :human_score, :computer_score, :current_round,
              :max_score, :round_winner, :human, :computer

  def initialize(max_score, human, computer)
    @max_score = max_score
    @current_round = 0
    @human = human
    @computer = computer
    @human_score = 0
    @computer_score = 0
    display_round_limit
  end

  def new_round
    self.round_winner = nil
    self.current_round += 1
  end

  def play_round
    display_round_num
    display_move_history
    human.choose
    computer.choose
  end

  def end_round
    display_moves
    set_winner
    display_round_winner
    update_score
  end

  def end_match
    winner = (human_score == max_score ? human : computer)
    anim_print("#{winner.name} has won #{max_score} rounds " \
               "to claim victory!", true)
  end

  def display_score
    anim_print("Your score: #{human_score}", true)
    sleep(QUICK_PAUSE)
    anim_print("#{computer.name}'s score: #{computer_score}", true)
    sleep(QUICK_PAUSE)
    blank_line
  end

  def winner?
    human_score == max_score || computer_score == max_score
  end

  private

  attr_writer :current_round, :round_winner, :human_score, :computer_score

  def display_round_limit
    anim_print("You'll be playing first to #{max_score} rounds!")
    blank_line
  end

  def set_winner
    if human.beats?(computer)
      self.round_winner = :human
    elsif computer.beats?(human)
      self.round_winner = :computer
    end
  end

  def update_score
    case round_winner
    when :human then self.human_score += 1
    when :computer then self.computer_score += 1
    end
  end

  def display_round_num
    anim_print "Round: #{current_round}"
    blank_line
    sleep(LONG_PAUSE)
  end

  def display_move_history
    return unless current_round > 1
    anim_print("#{human.name}'s History: ")
    print human.move_history_str
    sleep(QUICK_PAUSE)
    blank_line
    anim_print("#{computer.name}'s History: ")
    print computer.move_history_str
    sleep(QUICK_PAUSE)
    blank_line
  end

  def display_moves
    anim_print("#{human.name} chose #{human.move}.", true)
    anim_print("#{computer.name} chose #{computer.move}.", true)
    blank_line
  end

  def display_round_winner
    if round_winner == :human
      display_human_round_win
    elsif round_winner == :computer
      display_computer_round_win
    else
      anim_print("It's a tie!", true)
    end
    blank_line
  end

  def display_human_round_win
    anim_print(MSG["game"]["#{human.move}_#{computer.move}"], true)
    anim_print("#{human.name} won!", true)
  end

  def display_computer_round_win
    anim_print(MSG["game"]["#{computer.move}_#{human.move}"], true)
    anim_print("#{computer.name} won!", true)
  end
end

class RPSGame
  include Displayable

  REPLAY_VALUES = %w(y n)

  def initialize
    clear_screen
    display_welcome
    @human = Human.new
    @computer = Computer.new(human)
    @match = nil
  end

  def play
    loop do
      single_match
      break unless play_again?
      clear_screen
      new_computer_opponent
    end
    display_goodbye
  end

  private

  attr_accessor :human, :computer, :match

  def display_welcome
    anim_print(MSG["system"]["welcome"], true)
  end

  def display_goodbye
    anim_print(MSG["system"]["goodbye"], true)
  end

  def initialize_match
    rounds = rounds_to_win.to_i
    self.match = Match.new(rounds, human, computer)
  end

  def rounds_to_win
    user_input(MSG["system"]["how_many_rounds"], :positive_numeric)
  end

  def play_again?
    choice = user_input(MSG["system"]["play_again"], :yes_or_no, REPLAY_VALUES)
    return true if choice.downcase == 'y'
    return false if choice.downcase == 'n'
  end

  def new_computer_opponent
    self.computer = Computer.new(human)
  end

  def single_match
    initialize_match
    loop do
      single_round
      break if end_game?
    end
    display_grand_winner
  end

  def single_round
    match.new_round
    match.play_round
    match.end_round
    match.display_score
  end

  def end_game?
    match.winner?
  end

  def display_grand_winner
    match.end_match
  end
end

RPSGame.new.play
