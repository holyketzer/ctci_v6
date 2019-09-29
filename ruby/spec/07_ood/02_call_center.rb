class Employee
  def initialize(number)
    @number = number
  end

  def handle_call(call, call_center)
    call.employee = self

    Thread.new do
      sleep 0.1

      if only_this_file_run?(__FILE__)
        puts "Call #{call} handled by #{self}"
      end

      call_center.done_callback(call)
    end
  end

  def to_s
    "#{self.class} #{@number}"
  end
end

class Call
  attr_accessor :employee

  def initialize(number)
    @number = number
  end

  def to_s
    "call-#{@number}"
  end
end

Respondent = Class.new(Employee)
Manager = Class.new(Employee)
Director = Class.new(Employee)

class CallCenter
  def initialize()
    @waiting_calls = []
    @handled_calls = []

    @free_respondents = []
    @free_managers = []
    @free_directors = []

    @free_employees = {
      Respondent => @free_respondents,
      Manager => @free_managers,
      Director => @free_directors,
    }

    @free_employees_arr = [
      @free_respondents,
      @free_managers,
      @free_directors,
    ]
  end

  def add_employee(employee)
    @free_employees[employee.class] << employee
  end

  def dispatch_call(call)
    @waiting_calls << call
    handle_calls
  end

  def handle_calls
    while (@waiting_calls.any? && queue = @free_employees_arr.find { |q| q.any? }) do
      employee = queue.shift
      call = @waiting_calls.shift

      employee.handle_call(call, self)
    end
  end

  def done_callback(call)
    employee = call.employee
    @free_employees[employee.class] << employee
    @handled_calls << call
  end

  def handled_calls_count
    @handled_calls.size
  end

  def no_waiting_call?
    @waiting_calls.empty?
  end
end

RSpec.describe 'CallCenter' do
  let(:call_center) do
    CallCenter.new.tap do |call_center|
      call_center.add_employee(Director.new(1))

      call_center.add_employee(Manager.new(1))
      call_center.add_employee(Manager.new(2))

      call_center.add_employee(Respondent.new(1))
      call_center.add_employee(Respondent.new(2))
      call_center.add_employee(Respondent.new(3))
    end
  end

  let(:calls) { 10.times.map { |i| Call.new(i + 1) } }

  it do
    calls.each { |call| call_center.dispatch_call(call) }


    while call_center.handled_calls_count < calls.size do
      sleep 0.1
      call_center.handle_calls
    end
  end
end
