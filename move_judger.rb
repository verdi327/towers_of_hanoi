require_relative "result"

class MoveJudger
  attr_reader :towers, :move_number, :starting_disks

  def initialize(towers, move_number, starting_disks)
    @towers         = towers
    @move_number    = move_number
    @starting_disks = starting_disks
  end

  def determine
    if move_number.even?
      if starting_disks.even?
        rotate_smallest_disk_right
      else
        rotate_smallest_disk_left
      end
    else
      make_only_valid_move
    end
  end

  def possible_moves
    towers.map(&:top_disk)
  end

  def rotate_smallest_disk_right
    pm = possible_moves
    if pm[0] == 1
      Result.new({"1" => "tower_2"})
    elsif pm[1] == 1
      Result.new({"1" => "tower_3"})
    elsif pm[2] == 1
      Result.new({"1" => "tower_1"})
    end
  end

  def rotate_smallest_disk_left
    pm = possible_moves
    if pm[0] == 1
      Result.new({"1" => "tower_3"})
    elsif pm[1] == 1
      Result.new({"1" => "tower_1"})
    elsif pm[2] == 1
      Result.new({"1" => "tower_2"})
    end
  end

  def make_only_valid_move
    pm = possible_moves
    num = pm.compact.delete_if {|i| i == 1}.min
    if pm.include?(nil)
      index = pm.find_index(nil)
      case index
      when 0
        Result.new({"#{num}" => "tower_1"})
      when 1
        Result.new({"#{num}" => "tower_2"})
      when 2
        Result.new({"#{num}" => "tower_3"})
      end
    else
      if num < pm[0]
        Result.new({"#{num}" => "tower_1"})
      elsif num < pm[1]
        Result.new({"#{num}" => "tower_2"})
      elsif num < pm[2]
        Result.new({"#{num}" => "tower_3"})
      end
    end
  end
end