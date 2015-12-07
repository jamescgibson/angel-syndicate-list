class String
  def clean
    self.gsub(/\n/, "").strip
  end
end
