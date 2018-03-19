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
      par_account = create(:parent_account)
      subs_account = create(:subsidiary_account)
      AccountRelation.create(parent_account: par_account,
                             subsidiary_account: subs_account)
      expect(par_account.next).to include(subs_account)
    end
  end

  describe '#previous' do
    it 'when account has a parent account' do
      par_account = create(:parent_account)
      subs_account = create(:subsidiary_account)
      AccountRelation.create(parent_account: par_account,
                             subsidiary_account: subs_account)
      expect(subs_account.previous).to include(par_account)
    end
  end

  describe '#all_relations' do
    it 'returna a tree of relations do' do
      par_acc = create(:parent_account)
      subs_acc1 = create(:subsidiary_account)
      subs_acc2 = create(:subsidiary_account)
      subs_acc3 = create(:subsidiary_account)
      subs_acc4 = create(:subsidiary_account)
      subs_acc5 = create(:subsidiary_account)
      create(:account_relation, parent_account: par_acc, subsidiary_account: subs_acc1)
      create(:account_relation, parent_account: subs_acc1, subsidiary_account: subs_acc2)
      create(:account_relation, parent_account: subs_acc2, subsidiary_account: subs_acc3)
      create(:account_relation, parent_account: subs_acc3, subsidiary_account: subs_acc4)
      create(:account_relation, parent_account: subs_acc4, subsidiary_account: subs_acc5)
      relations = par_acc.all_relations
      expect(relations.count).to eq(6)
      expect(relations).to include(subs_acc5)
    end
  end
end
