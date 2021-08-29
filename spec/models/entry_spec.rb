RSpec.describe Entry do
  describe ".create_invalid_entry" do
    it "is invalid in the future" do
      expect(FactoryBot.build(:entry, start_date: Time.now + 1.day, end_date: Time.now + 1.day)).not_to be_valid
    end
    it "is invalid start date" do
      expect(FactoryBot.build(:entry, start_date: Time.now + 1.hour, end_date: Time.now)).not_to be_valid
    end
    context "overlapping timesheet " do
      let(:entry1) {create :entry, start_date: Time.now, end_date: Time.now + 1.hour}
      let(:entry2) {create :entry, start_date: Time.now, end_date: Time.now + 1.hour}
      it "is invalid overlap" do
        expect(entry2).not_to be_valid
      end
    end
  end

  describe ".create_valid_entry" do
    it "is valid" do
      expect(FactoryBot.build(:entry, start_date: Time.now-1.hour, end_date: Time.now)).to be_valid
    end
  end
end
