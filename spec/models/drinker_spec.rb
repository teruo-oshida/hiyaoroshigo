require 'rails_helper'

RSpec.describe Drinker, type: :model do
  describe '#sake_title' do
    subject { drinker.sake_title }

    before { Timecop.freeze }
    after { Timecop.return }

    context 'with no drinking' do
      let(:drinker) { create(:drinker) }
      it { expect(subject).to eq('酒勇者見習い') }
    end

    context 'with 4 drinkings' do
      let(:drinker) { create(:drinker, drinking_count: 4) }
      it { expect(subject).to eq('酒勇者見習い') }
    end

    context 'with 5 drinkings' do
      let(:drinker) { create(:drinker, drinking_count: 5) }
      it { expect(subject).to eq('日本酒初級戦士') }
    end

    context 'with 7 drinkings' do
      let(:drinker) { create(:drinker, drinking_count: 7) }
      it { expect(subject).to eq('日本酒初級戦士') }
    end

    context 'with 8 drinkings' do
      let(:drinker) { create(:drinker, drinking_count: 8) }
      it { expect(subject).to eq('山陰酒武闘家') }
    end

    context 'with 9 drinkings' do
      let(:drinker) { create(:drinker, drinking_count: 9) }
      it { expect(subject).to eq('山陰酒武闘家') }
    end

    context 'with 10 drinkings' do
      context 'with 9 minutes interval' do
        let(:drinker) do
          create(:drinker, drinking_count: 10, drinking_interval: 9.minutes)
        end
        it { expect(subject).to eq('呑み過ぎ遊び人') }
      end

      context 'with 10 minutes interval' do
        let(:drinker) do
          create(:drinker, drinking_count: 10, drinking_interval: 10.minutes)
        end
        it { expect(subject).to eq('伝説の酒勇者') }
      end
    end

    context 'with 14 drinkings' do
      context 'with 9 minutes interval' do
        let(:drinker) do
          create(:drinker, drinking_count: 10, drinking_interval: 9.minutes)
        end
        it { expect(subject).to eq('呑み過ぎ遊び人') }
      end

      context 'with 10 minutes interval' do
        let(:drinker) do
          create(:drinker, drinking_count: 10, drinking_interval: 10.minutes)
        end
        it { expect(subject).to eq('伝説の酒勇者') }
      end
    end

    context 'with 15 drinkings' do
      context 'with 4 minutes interval' do
        let(:drinker) do
          create(:drinker, drinking_count: 15, drinking_interval: 4.minutes)
        end
        it { expect(subject).to eq('呑み過ぎ遊び人') }
      end

      context 'with 5 minutes interval' do
        let(:drinker) do
          create(:drinker, drinking_count: 15, drinking_interval: 5.minutes)
        end
        it { expect(subject).to eq('伝説の酒勇者') }
      end
    end
  end
end
