require "bundler/setup"

class VendingMachine
  attr_reader :total_accepted_money, :juice_stocks, :sales

  ACCEPTABLE_MONEY_LIST = [
    10, 50, 100, 500, 1000
  ]

  def initialize(juice_stocks = [Juice.new(:coke, 120)]*5)
    @total_accepted_money = 0
    @purchased = 0
    @sales = 0
    @juice_stocks = juice_stocks
  end

  def accept_money(money)
    # 受け付ける対象じゃない場合、そのままmoneyを返す
    return money unless ACCEPTABLE_MONEY_LIST.include?(money)

    @total_accepted_money += money
  end

  def payback
    payback_money = current_money
    @total_accepted_money = 0
    @purchased = 0
    payback_money
  end

  def purchasable?(juice_name)
    target = @juice_stocks.find{|juice| juice.name == :coke}
    target && current_money >= target.price
  end

  def sell(juice_name)
    return unless purchasable?(juice_name)
    target = @juice_stocks.find{|juice| juice.name == :coke}
    reduce_juice_stock(juice_name)
    @purchased += target.price
    @sales += target.price
  end

  def get_juice_stock_count(juice_name)
    @juice_stocks.select{|juice| juice.name == :coke}.size
  end

  private 
  def current_money
    @total_accepted_money - @purchased
  end

  def reduce_juice_stock(juice_name)
    target_index = @juice_stocks.index{|juice| juice.name == :coke}
    target_index && @juice_stocks.delete_at(target_index)
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
