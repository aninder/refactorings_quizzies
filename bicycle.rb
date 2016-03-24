# from book oo design in ruby by matz
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel= nil)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end
  def ratio
    @chainring / @cog.to_f
  end
  def gear_inches
    wheel.diameter * ratio
  end
end

class Wheel
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end
  def diameter
    rim + (tire * 2)
  end
  def circumference
    diameter * Math::PI
  end
end
