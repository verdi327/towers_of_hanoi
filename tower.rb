class Tower
  attr_accessor :disks

  def initialize(disks=[])
    @disks = disks
  end

  def add(disk)
    disks.unshift(disk)
  end

  def remove
    disks.slice!(0)
  end

  def top_disk
    disks.first
  end
end