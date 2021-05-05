class BackstagePasses < Item
  def self.match(name)
    name =~ /Backstage passes/
  end

  def update
    @sell_in -= 1
    @quality = new_quality
    @quality = quality.clamp(0, 50)
  end

  private

  def new_quality
    case sell_in
    when (10..) then quality + 1
    when (5..) then quality + 2
    when (0..) then quality + 3
    else 0
    end
  end
end
