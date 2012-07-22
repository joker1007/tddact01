require "bundler/setup"

class VendingMachine
  attr_accessor :total_accepted_money

  def initialize
    @total_accepted_money = 0
  end

  def accept_money(money)
    @total_accepted_money += money
  end
end
