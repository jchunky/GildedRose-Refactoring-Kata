class BackstagePasses < SimpleDelegator
  def self.match(name)
    name =~ /Backstage passes/
  end

  def update
    self.sell_in -= 1
    self.quality = next_quality
    self.quality = quality.clamp(0, 50)
  end

  private

  def next_quality
    case sell_in
    when (10..) then quality + 1
    when (5..) then quality + 2
    when (0..) then quality + 3
    else 0
    end
  end
end
