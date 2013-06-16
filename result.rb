class Result
  attr_reader :disk, :tower

  def initialize(hash)
    @disk = hash.keys.first.to_i
    @tower = hash.values.first
  end
end