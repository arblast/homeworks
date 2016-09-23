class LRUCache

  def initialize(size)
    @size = size
    @cache = []
  end

  def count
    @cache.length
    # returns number of elements currently in cache
  end

  def add(el)
    if @cache.length > @size
      @cache.shift
    end
    if @cache.include?(el)
      @cache.delete(el)
    end
      @cache << el
    # adds element to cache according to LRU principle
  end

  def show
    p @cache
    nil
    # shows the items in the cache, with the LRU item first
  end


end
