
require File.dirname(__FILE__) + '/vending_machine'

describe VendingMachine do 

  it 'returns total accespted money' do
    subject.total_accepted_money.should == 0
    subject.accespt_coint(100)
    subject.total_accepted_money.should == 100
  end

end

