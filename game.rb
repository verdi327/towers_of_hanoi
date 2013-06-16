require_relative "move_judger"
require_relative "result"
require_relative "tower"

class Game
  attr_reader :starting_disks
  attr_accessor :move_number, :towers

  def initialize(starting_disks=4)
    @starting_disks = starting_disks
    @move_number    = 0
    @towers         = [Tower.new((1..starting_disks).to_a), Tower.new, Tower.new]
  end

  def play
    until game_over
      puts move_number
      move = MoveJudger.new(towers, move_number,starting_disks).determine #=> {result object :disk, :tower methods}
      puts "move #{move.disk} to #{move.tower}"
      perform(move)
      current_game_state
      format
      self.move_number += 1
    end
  end

  def perform(move)
    towers.each {|tower| tower.remove if tower.top_disk == move.disk }
    move.tower.add(move.disk)
  end

  def current_game_state
    towers.each_with_index do |tower,i|
      i = i + 1
      print "Tower #{i}: #{tower.disks}\n"
    end
  end

  def format
    puts ""
    puts "----------"
    puts ""
  end

  def game_over
    sorted = tower_3.disks.sort
    tower_3.disks.size == starting_disks && tower_3.disks == sorted
  end
end


