class Board
  attr_accessor :cups


  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups = Array.new(14) {[]}
    @opp_store = { name1 => 13, name2 => 6}
    @own_store = { name1 => 6, name2 => 13}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index { |cup, ind| 4.times {cup << :stone} unless ind == 6 || ind == 13 }
  end

  def valid_move?(start_pos)
    if @cups[start_pos] == [] || @cups[start_pos] == nil
      raise "Invalid starting cup"
    end
  end

  def parse_move(move_pos)
    return move_pos -1 if move_pos.between?(1,6)
    return move_pos
  end

  def make_move(start_pos, current_player_name)
    start_pos = parse_move(start_pos)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    current_pos = start_pos+1
    until stones == []
      current_pos = current_pos%14
      @cups[current_pos] << stones.pop unless current_pos == @opp_store[current_player_name]
      current_pos += 1
    end
    self.render
    next_turn(current_pos - 1, current_player_name)
      #make_move(next_cup, current_player_name)
  end

  def next_turn(ending_cup_idx, current_player_name)
    # helper method to determine what #make_move returns
    if ending_cup_idx == @own_store[current_player_name]
      return :prompt
    elsif @cups[ending_cup_idx].length == 1
      return :switch
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def cups_empty?
    @cups[0..5].all? {|cup| cup.empty?} || @cups[7..12].all? {|cup| cup.empty?}
  end

  def winner
    if @cups[6] == @cups[13]
      return :draw
    elsif @cups[6].length > @cups[13].length
      return @name1
    else
      return @name2
    end

  end
end
