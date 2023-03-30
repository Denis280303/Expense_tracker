require 'rails_helper'

RSpec.describe Expense do
  subject(:record) { described_class.new }

  describe 'Relations' do
    it { expect(record).to belong_to(:user) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:expense_type) }
    it { is_expected.to validate_presence_of(:value) }

    context 'when expense_type' do
      it do
        expect(Expense::CATEGORIES).to eq ['Traveling', 'Clothing', 'Taxi', 'Cafes', 'Shops', 'Other']
        expect(record).to allow_values(0, 1, 2, 3, 4, 5).for(:expense_type)
      end
    end

    context 'when value' do
      it do
        expect(record).to allow_values(1, 24, 333333).for(:value)
      end
    end
  end
end