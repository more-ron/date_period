require 'spec_helper'

describe DatePeriod::Month do

  subject(:prev_month) { described_class.new(year: 1982, month: 1) }
  subject(:month) { described_class.new(year: 1982, month: 2) }
  subject(:next_month) { described_class.new(year: 1982, month: 3) }

  describe '.including' do
    it { expect(DatePeriod::Month.including "1982-01-15").to eq prev_month }
    it { expect(DatePeriod::Month.including "1982-02-15").to eq month }
  end

  describe '.current' do
    it { expect(DatePeriod::Month.current).to include Date.current }
  end

  describe '.load' do
    it { expect(DatePeriod::Month.load '{"year":1982,"month":2}').to eq month }
  end

  describe '.dump' do
    it { expect(DatePeriod::Month.dump month).to eq '{"year":1982,"month":2}' }
  end

  describe '#first_day' do
    it { expect(month.first_day).to eq "1982-02-01".to_date }
  end

  describe '#last_day' do
    it { expect(month.last_day).to eq "1982-02-28".to_date }
  end

  describe '#date_period' do
    it { expect(month.date_period).to eq ("1982-02-01".to_date .. "1982-02-28".to_date) }
  end

  describe '#first_moment' do
    it { expect(month.first_moment).to eq "1982-02-01".to_date.beginning_of_day }
  end

  describe '#last_moment' do
    it { expect(month.last_moment).to eq "1982-02-28".to_date.end_of_day }
  end

  describe '#time_period' do
    it { expect(month.time_period.begin).to eq (Time.use_zone(Time.zone) { "1982-02-01".to_date.beginning_of_day }) }
    it { expect(month.time_period.end).to eq (Time.use_zone(Time.zone) { "1982-02-28".to_date.end_of_day }) }
  end

  describe '#prev' do
    it { expect(month.prev).to eq prev_month }
  end

  describe '#next' do
    it { expect(month.next).to eq next_month }
  end

  describe '#include?' do
    it { expect(month).to include "1982-02-15".to_date }
    it { expect(month).not_to include "1982-01-15".to_date }
  end

  describe '#to_date' do
    it { expect(month.to_date).to eq "1982-02-01".to_date }
  end

  describe '#date_period' do
    it { expect(month.date_period).to eq ("1982-02-01".to_date .. "1982-02-28".to_date) }
  end

  describe 'rangeability' do
    it { expect { prev_month .. next_month }.to_not raise_error }
  end

  describe 'comparability' do
    it { expect(month).to eq described_class.new(year: 1982, month: 2) }
  end

  describe 'computability' do
    it { expect(month + 1.month).to eq next_month }
    it { expect(month + 1).to eq next_month }
    it { expect(month - 1.month).to eq prev_month }
    it { expect(month - 1).to eq prev_month }
  end

  describe 'groupability' do
    let(:item_1) { double(:item, id: 1, month: DatePeriod::Month.new(year: 1982, month: 1)) }
    let(:item_2) { double(:item, id: 2, month: DatePeriod::Month.new(year: 1982, month: 1)) }
    let(:item_3) { double(:item, id: 3, month: DatePeriod::Month.new(year: 1982, month: 2)) }
    let(:item_4) { double(:item, id: 4, month: DatePeriod::Month.new(year: 1982, month: 2)) }
    let(:item_5) { double(:item, id: 5, month: DatePeriod::Month.new(year: 1982, month: 3)) }
    let(:item_6) { double(:item, id: 6, month: DatePeriod::Month.new(year: 1982, month: 3)) }
    
    let(:collection) {[
      item_1,
      item_2,
      item_3,
      item_4,
      item_5,
      item_6,
    ]}
    
    example {
      groups = collection.group_by(&:month)
      expect(groups[DatePeriod::Month.new(year: 1982, month: 2)]).not_to include item_2
      expect(groups[DatePeriod::Month.new(year: 1982, month: 2)]).to include item_3
      expect(groups[DatePeriod::Month.new(year: 1982, month: 2)]).to include item_4
      expect(groups[DatePeriod::Month.new(year: 1982, month: 2)]).not_to include item_5
    }
  end

end