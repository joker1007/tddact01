require "bundler/setup"

class VendingMachine
  attr_reader :total_accepted_money

  def initialize
    @total_accepted_money = 0
  end

  def accept_money(money)
    @total_accepted_money += money
  end

  def payback
    before_total_accepted_money = total_accepted_money
    @total_accepted_money = 0
    before_total_accepted_money
  end
end
