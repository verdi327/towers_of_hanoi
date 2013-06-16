require_relative "result"

class MoveJudger
  attr_reader :towers, :move_number, :starting_disks

  def initialize(towers, move_number, starting_disks)
    @towers         = towers
    @move_number    = move_number
    @starting_disks = starting_disks
  end

  def determine
    move_number.even? ? rotate_smallest_disk : make_only_valid_move
  end

  def rotate_smallest_disk
    if starting_disks.even?
      rotate_smallest_disk_right
    else
      rotate_smallest_disk_left
    end
  end

  def rotate_smallest_disk_right
    disc = Disc.new(1)
    next_move(disc)
  end

  def rotate_smallest_disk_left
    next_move(Disc.new(1) "left"))
  end

  def next_move(disc, direction = "right")
    towers = towers.reverse unless "right"
    towers.each do |tower|
      if tower.move?(disc)
        result = Result.new(disc, tower)
      end
    end
    result
  end
end
