require 'rails_helper'

RSpec.describe Account, type: :model do
  before :each do
    @account = create(:account_with_100)
  end

  describe '#amount_holded' do
    it 'returns account_balance' do
      expect(@account.amount_holded.to_i).to eq(100)
    end
  end

  describe '#debit' do
    context 'when account has enough monay' do
      it 'transaction discounted correctly' do
        @account.debit(50)
        expect(@account.amount_holded.to_i).to eq(50)
      end
    end

    context 'when account run out of enough money' do
      it 'transaction will fail' do
        expect(@account.debit(150)).to be_falsy
        expect(@account.amount_holded.to_i).to eq(100)
      end
    end
  end

  describe '#credit' do
    it 'some credit must be added ueba' do
      @account.credit(100)
      expect(@account.amount_holded.to_i).to eq(200)
    end
  end

  describe '#debit_peremited?' do
    it 'Discount greater than amount holded' do
      expect(@account.debit_permited?(1000)).to be_falsy
    end

    it 'Discount less than amount holded' do
      expect(@account.debit_permited?(10)).to be_truthy
    end
  end

  describe '#next' do
    it 'when account has a child account' do
      parent_account = create(:parent_account)
      subsidiary_account = create(:subsidiary_account)
      AccountRelation.create(above_ac: parent_account, below_ac: subsidiary_account)
      expect(parent_account.next).to include(subsidiary_account)
    end
  end


  describe '#previous' do
    it 'when account has a parent account' do
      parent_account = create(:parent_account)
      subsidiary_account = create(:subsidiary_account)
      AccountRelation.create(above_ac: parent_account, below_ac: subsidiary_account)
      expect(subsidiary_account.previous).to include(parent_account)
    end
  end
end
