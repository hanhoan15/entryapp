RSpec.describe "EntrySerializer" do
  let(:entry) {create :entry, start_date: Time.now, end_date: Time.now+1.hour}
  let(:serializer) {Entries::EntrySerializer.new(entry)}

  it 'has the same date' do
    expect(serializer.serializable_hash[:date]).to eql(entry.start_date.strftime(I18n.t('date.formats.date_format')))
  end

  it 'has the same start_time' do
    expect(serializer.serializable_hash[:start_time]).to eql(entry.start_date.strftime(I18n.t('date.formats.time_format')))
  end

  it "has the same end_time" do
    expect(serializer.serializable_hash[:end_time]).to eql(entry.end_date.strftime(I18n.t('date.formats.time_format')))
  end
end
