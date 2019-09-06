class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{self.class.downcase}-#{name}"
  end
end

class Dog < Animal
end

class Cat < Animal
end

class AnimalContainer
  attr_reader :animal, :number

  def initialize(animal, number)
    @animal = animal
    @number = number
  end
end

class AnimalShelter
  def initialize
    @dogs = LinkedList.new
    @cats = LinkedList.new
    @number = 1
  end

  def enqueue(animal)
    container = AnimalContainer.new(animal, @number)
    @number += 1

    if animal.is_a?(Dog)
      @dogs.push(container)
    else
      @cats.push(container)
    end
  end

  def dequeue_cat
    if !@cats.empty?
      @cats.pop.animal
    end
  end

  def dequeue_dog
    if !@dogs.empty?
      @dogs.pop.animal
    end
  end

  def dequeue_any
    if !@dogs.empty? && !@cats.empty?
      if @dogs.head_value.number < @cats.head_value.number
        @dogs.pop.animal
      else
        @cats.pop.animal
      end
    elsif !@dogs.empty?
      @dogs.pop.animal
    elsif !@cats.empty?
      @cats.pop.animal
    end
  end
end

RSpec.describe AnimalShelter do
  let(:shelter) { AnimalShelter.new }

  let(:thomas) { Cat.new('Thomas') }
  let(:murka) { Cat.new('Murka') }
  let(:matroskin) { Cat.new('Matroskin') }

  let(:sharik) { Dog.new('Sharik') }
  let(:polkan) { Dog.new('Polkan') }
  let(:azor) { Dog.new('Azor') }

  describe 'enqueue - dequeue' do
    it do
      shelter.enqueue(thomas)
      shelter.enqueue(murka)
      shelter.enqueue(matroskin)

      shelter.enqueue(sharik)
      shelter.enqueue(polkan)
      shelter.enqueue(azor)

      expect(shelter.dequeue_any).to eq thomas
      expect(shelter.dequeue_dog).to eq sharik
      expect(shelter.dequeue_cat).to eq murka
      expect(shelter.dequeue_dog).to eq polkan

      expect(shelter.dequeue_any).to eq matroskin
      expect(shelter.dequeue_any).to eq azor

      expect(shelter.dequeue_any).to eq nil
    end
  end
end
