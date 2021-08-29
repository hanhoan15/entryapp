RSpec.describe "Entry service test" do
  let(:service) {Entries::EntryService.new}
  let(:entry) {create :entry, start_date: Time.now, end_date: Time.now + 1.hour}

  describe "entry service price test" do
    context "15/04/2019: 10:00 - 17:00" do
      before {
        entry.start_date = DateTime.new(2019, 4, 15, 10, 0)
        entry.end_date = DateTime.new(2019, 4, 15, 17, 0)
      }
      it 'price' do
        expect(service.get_price(entry)).to eq(154)
      end
    end

    context "16/04/2019: 12:00 - 20:15" do
      before {
        entry.start_date = DateTime.new(2019, 4, 16, 12, 0)
        entry.end_date = DateTime.new(2019, 4, 16, 20, 15)
      }
      it 'price' do
        expect(service.get_price(entry)).to eq(238.75)
      end
    end

    context "12/04/2019: 04:00 - 21:30" do
      before {
        entry.start_date = DateTime.new(2019, 4, 12, 4, 0)
        entry.end_date = DateTime.new(2019, 4, 12, 21, 30)
      }
      it 'price' do
        expect(service.get_price(entry)).to eq(451)
      end
    end

    context "20/04/2019: 15:30 - 20:00" do
      before {
        entry.start_date = DateTime.new(2019, 4, 20, 15, 30)
        entry.end_date = DateTime.new(2019, 4, 20, 20, 0)
      }
      it 'price' do
        expect(service.get_price(entry)).to eq(211.5)
      end
    end

    context "17/04/2019: 02:00 - 06:00" do
      before {
        entry.start_date = DateTime.new(2019, 4, 17, 2, 0)
        entry.end_date = DateTime.new(2019, 4, 17, 6, 0)
      }
      it 'price' do
        expect(service.get_price(entry)).to eq(136)
      end
    end
  end
end
