require 'byebug'
require_relative 'employee'

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss)
    @employees = []
    super
  end

  def bonus(multiplier)
    total_sum = 0
    bonus = 0
    employees.each do |employee|
      bonus += employee.bonus(multiplier) if employee.is_a?(Manager)
      total_sum += employee.salary
    end
    (total_sum * multiplier) + bonus
  end
end
