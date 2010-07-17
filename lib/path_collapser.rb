class PathCollapser

  def initialize
    @patterns = []
  end

  def add pattern
    @patterns << pattern
  end

  def collapse path
    @patterns.each do |pattern|
      return pattern if path =~ Regexp.new("^#{pattern}$")
    end
    path
  end

end