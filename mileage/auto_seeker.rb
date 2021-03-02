require './auto'

class AutoSeeker

  def initialize data
    @data = data
  end

  def filter key, match
    @autos = autos.select do |auto|
      auto.send(key) == match
    end
  end

  def autos
    @autos ||= @data.map do |row|
      Auto.new(row)
    end
  end

  def self.median_mileage autos
    # there is a nil value in the dataset that is causing .sort to fail
    # I am just rejecting any nil values I find and then sorting the remaining elements
    prices = autos.collect(&:mileage).reject(&:nil?).sort
    (prices[(prices.length - 1) / 2].to_f + prices[prices.length / 2].to_f) / 2.0
  end

  def self.price_range_filter(autos,low,high)
    raise "Invalid Range" if low > high
    autos.select { |auto| auto.price >= low && auto.price <= high }

  end

  def self.fuel_type_filter(autos, fuel_type)
    # The README states that I should write out this method, but this logic can be handled
    #   by the filter method by using .filter(:fuel, "gas") on an AutoSeeker instance
    return autos.select { |auto| auto.fuel == fuel_type }
  end

end
