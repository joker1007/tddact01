require "bundler/setup"

class VendingMachine
  attr_reader :total_accepted_money

  ACCEPTABLE_MONEY_LIST = [
    10, 50, 100, 500, 1000
  ]

  def initialize
    @total_accepted_money = 0
  end

  def accept_money(money)
    # 受け付ける対象じゃない場合、nil
    return nil unless ACCEPTABLE_MONEY_LIST.include?(money)

    @total_accepted_money += money
    money
  end

  def payback
    before_total_accepted_money = total_accepted_money
    @total_accepted_money = 0
    before_total_accepted_money
  end
end
