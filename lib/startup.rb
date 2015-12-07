class Startup < AngelObj
  def name
    page.css("h1.name").first&.text.clean
  end

  def tags
    page.css(".tag").map(&:text).map(&:clean).uniq
  end
end
