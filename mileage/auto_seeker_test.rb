require "minitest/autorun"
require "./auto_seeker"

describe AutoSeeker do
  before do
    data = [
      [1,'Red',12999,20.0,'gas'],
      [2,'Blue',13999,25.0,'gas'],
      [3,'Teal',19000,27.0,'gas'],
      [4,'Red',14999,40.0,'diesel'],
    ]

    @seeker = AutoSeeker.new data
    ######################################

    data_with_nil = [
      [1,'Red',12999,nil,'gas'],
      [2,'Blue',13999,25.0,'gas'],
      [3,'Teal',19000,27.0,'gas'],
      [4,'Red',14999,40.0,'diesel']
    ]

    @seeker_with_nil = AutoSeeker.new data_with_nil
  end


  describe "#filter " do
    it "can filter by color " do
      @seeker.filter 'color', 'Red'
      @seeker.autos.collect(&:color).uniq.must_equal ['Red']
    end
  end

  describe ".median_mileage " do
    # it seems as though this should be ::median_mileage to denote a class method
    it "calculates median mileage for all autos" do
      AutoSeeker.median_mileage(@seeker.autos).must_equal 26.0
    end

    it "disregards nil values" do
      AutoSeeker.median_mileage(@seeker_with_nil.autos).must_equal 27.0
    end
  end

  describe "price_range_filter" do
    it "returns car instances whos price is within the specified range" do
      AutoSeeker.price_range_filter(@seeker.autos,14000,20000)
        .map(&:id).sort.must_equal [3,4]
    end

    it "returns empty array when no cars are within range" do
      AutoSeeker.price_range_filter(@seeker.autos,0,100).must_equal []
    end

    it "errors when the low is larger than the high" do
      assert_raises "Invalid Range" do 
        AutoSeeker.price_range_filter(@seeker.autos,100000,100)
      end
    end
  end

  describe "fuel_type_filter" do
    it "returns cars that match the given fuel type" do
      AutoSeeker.fuel_type_filter(@seeker.autos,"gas")
        .map(&:id).sort.must_equal [1,2,3]
    end

    it "does not return non-matching fuel types" do
      AutoSeeker.fuel_type_filter(@seeker.autos,"nuclear").must_equal []
    end
  end
end
