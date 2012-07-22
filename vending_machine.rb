require "bundler/setup"

class VendingMachine
  attr_reader :total_accepted_money, :juice_stocks, :sales

  ACCEPTABLE_MONEY_LIST = [
    10, 50, 100, 500, 1000
  ]

  def initialize
    @total_accepted_money = 0
    @purchased = 0
    @sales = 0
    @juice_stocks = [Juice.new(:coke, 120)]*5
  end

  def accept_money(money)
    # 受け付ける対象じゃない場合、そのままmoneyを返す
    return money unless ACCEPTABLE_MONEY_LIST.include?(money)

    @total_accepted_money += money
  end

  def current_money
    @total_accepted_money - @purchased
  end

  def payback
    before_total_accepted_money = total_accepted_money
    @total_accepted_money = 0
    before_total_accepted_money
  end

  def purchasable?(juice_name)
    target = @juice_stocks.find{|juice| juice.name == :coke}
    current_money >= target.price
  end

  def sell(juice_name)
    return unless purchasable?(juice_name)
    target = @juice_stocks.find{|juice| juice.name == :coke}
    @sales += target.price
  end
end

class Juice
  attr_accessor :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  def == (other)
    @name == other.name && @price == other.price
  end
end
