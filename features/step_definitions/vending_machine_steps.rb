#coding:utf-8

前提 /^自販機が存在する$/ do
  @vending_machine = VendingMachine.new([])
end

前提 /^自販機は在庫として(\d+)円の((?:コーラ|レッドブル|水))を(\d+)本持っている$/ do |price, name_ja, count|
  name = get_juice_name_from(name_ja)
  count.to_i.times do
    @vending_machine.add_juice_stock(Juice.new(name, price.to_i))
  end
end

もし /^客が(\d+)円を自販機に投入する$/ do |money|
  @vending_machine.accept_money(money.to_i)
end

もし /^客が((?:コーラ|レッドブル|水))を購入する$/ do |name_ja|
  name = get_juice_name_from(name_ja)
  @juice = @vending_machine.sell(name)
end

ならば /^自販機は((?:コーラ|レッドブル|水))を出す$/ do |name_ja|
  name = get_juice_name_from(name_ja)
  @juice.name.should == name
end

def get_juice_name_from(name_ja)
  case name_ja
    when "コーラ"
      :coke
    when "レッドブル"
      :redbull
    when "水"
      :water
    end
end