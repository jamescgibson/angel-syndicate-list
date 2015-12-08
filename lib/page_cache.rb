require "singleton"

class PageCache
  include Singleton

  def initialize
    @data = {}
  end

  def fetch(key)
    if @data.keys.include? key
      LOGGER.info "Cached   #{key}"
      @data[key]
    else
      LOGGER.info "Fetching #{key}"
      data = open(key).read
      @data[key] = data
      data
    end
  end
end
