class Car
  attr_reader :number

  def initialize(number)
    @number = number
  end
end

class Place
  attr_reader :number, :car

  def initialize(number)
    @number = number
  end

  def free?
    car == nil
  end

  def put_car(car)
    @car = car
    @from = Time.current
  end

  def make_invoice
    hours = ((Time.current - @from) / 1.hour).ceil
    Invoice.new(@car, hours)
  end

  def leave
    @car = nil
    @from = nil
  end
end

class Invoice
  HOUR_RATE = 2.50

  def initialize(car, hours)
    @car = car
    @hours = hours
  end

  def total
    @hours * HOUR_RATE
  end
end

class ParkingLot
  def initialize(places_count)
    @places = places_count.times.map { |i| Place.new(i + 1) }

    @free_places = @places.select(&:free?)
    @busy_places = {}  # car number to busy place
  end

  def park(car)
    if @free_places.any?
      place = @free_places.shift
      @busy_places[car.number] = place
    end
  end

  def leave(car)
    if (place = @busy_places[car.number])
      @free_places << @busy_places.delete(car.number)
      place.make_invoice.tap { place.leave }
    end
  end

  def free_places_count
    @free_places.size
  end
end
