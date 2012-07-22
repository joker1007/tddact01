require File.dirname(__FILE__) + '/vending_machine'

require "rspec-parameterized"

describe VendingMachine do 

  it 'returns total accespted money' do
    subject.total_accepted_money = 100
    subject.total_accepted_money.should == 100
  end

  describe "#accept_money(money)" do
    with_them do
      it "should add money to total_accepted_money" do
        subject.accept_money(money)
        subject.total_accepted_money.should == expected
      end
    end

    where(:money, :expected) do
      [
        [10, 10],
        [100, 100]
      ]
    end

    context "multi accept" do
      with_them do
        it "should add money to total_accepted_money" do
          subject.accept_money(money1)
          subject.accept_money(money2)
          subject.total_accepted_money.should == expected
        end
      end

      where(:money1, :money2, :expected) do
        [
          [10, 10, 20],
          [100, 10, 110]
        ]
      end

    end
  end
end

