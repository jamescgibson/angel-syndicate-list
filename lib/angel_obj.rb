class AngelObj
  attr_reader :url

  def initialize(url)
    @url = url
  end

  protected

  def host
    "https://angel.co"
  end

  def logger
    return @@logger if defined?(@@logger)
    @@logger = Logger.new(STDOUT)
    @@logger.level = LOG_LEVEL || Logger::INFO
    @@logger
  end

  def page
    return @page if @page
    logger.info "Fetching #{url}"
    @page = Nokogiri::HTML(open(url))
   rescue StandardError => e
     logger.error "Execption fetching #{url}"
     @page = Nokogiri::HTML("<html></html>")
  end
end
