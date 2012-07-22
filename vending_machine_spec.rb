#coding:utf-8

require File.dirname(__FILE__) + '/vending_machine'

require "rspec-parameterized"

describe VendingMachine do 

  describe "#accept_money(money)" do
    with_them do
      it "should add money to total_accepted_money" do
        expect {
          subject.accept_money(money)
        }.to change(subject, :total_accepted_money).by(expected)
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
          expect {
            subject.accept_money(money1)
            subject.accept_money(money2)
          }.to change(subject, :total_accepted_money).by(expected)
        end
      end

      where(:money1, :money2, :expected) do
        [
          [10, 10, 20],
          [100, 10, 110]
        ]
      end

      context "unacceptable money" do
        with_them do
          it "should not accept money" do
            expect {
              subject.accept_money(money1)
              subject.accept_money(money2)
            }.to change(subject, :total_accepted_money).by(0)
          end
        end

        where(:money1, :money2) do
          [
            [1, 1],
            [1, 5],
            [5000, 10000],
            [10000, 1],
          ]
        end
      end
    end
  end

  describe "#payback" do
    with_them do
      it "should return total_accepted_money" do
        subject.accept_money(money)
        subject.payback.should == expected
        subject.total_accepted_money.should == 0
      end
    end

    where(:money, :expected) do
      [
        [0, 0],
        [10, 10],
        [100, 100]
      ]
    end
  end

  describe "#juice_stocks" do
    it "should return a juice array" do
      subject.juice_stocks.should == [Juice.new(:coke, 120)]*5
    end
  end

  describe "#purchasable?(juice_name)" do
    context "accept_money not yet" do
      it do
        subject.purchasable?(:coke).should be_false
      end
    end

    context "after accept_money(120)" do
      before do
        subject.accept_money(100)
        subject.accept_money(10)
        subject.accept_money(10)
      end

      it { subject.purchasable?(:coke).should be_true }
    end

    context "after accept_money(110)" do
      before do
        subject.accept_money(100)
        subject.accept_money(10)
      end

      it { subject.purchasable?(:coke).should be_false }
    end

    context "after accept_money(130)" do
      before do
        subject.accept_money(100)
        3.times { subject.accept_money(10) }
      end

      it { subject.purchasable?(:coke).should be_true }
    end
  end

  describe "#sell(juice_name)" do
    context "コウニュウデキヤす" do
      before do
        subject.accept_money(100)
        subject.accept_money(10)
        subject.accept_money(10)
      end

      it do
        expect {
          subject.sell(:coke)
        }.to change(subject, :sales).by(120)
      end

    end
    context "購入できない" do
      
      before do
        subject.accept_money(100)
      end

      it do
        expect {
          subject.sell(:coke)
        }.to change(subject, :sales).by(0)
      end

    end


  end
end

