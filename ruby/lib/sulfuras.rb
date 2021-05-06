class Sulfuras < SimpleDelegator
  def self.match(name)
    name =~ /Sulfuras/
  end

  def update
    # no-op
  end
end
