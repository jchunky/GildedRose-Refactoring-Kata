class Sulfuras < Item
  def self.match(name)
    name =~ /Sulfuras/
  end

  def update
    # no-op
  end
end
