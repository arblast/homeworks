class Map

  def initialize
    @map = []
  end

  def assign(key, value)
    unless has_key?(key)
      @map << [key, value]
    else
      change_val(key,value)
    end
  end

  def lookup(key)
    pair = @map.select { |pair| pair[0] == key}
    pair[0][1]
  end

  def remove(key)
    @map.delete_if { |pair| pair[0] == key}
  end

  def show
    @map
  end

  private

  def has_key?(key)
    @map.each { |pair| return true if pair[0] == key}
    return false
  end

  def change_val(key, value)
    @map.each { |pair| pair[1] = value if pair[0] == key}
  end

end
