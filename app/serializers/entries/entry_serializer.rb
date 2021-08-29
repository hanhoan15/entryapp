module Entries
  class EntrySerializer < ActiveModel::Serializer
    attributes :date, :start_time, :end_time, :price

    def date
      object.start_date.strftime(I18n.t('date.formats.date_format'))
    end

    def start_time
      object.start_date.strftime(I18n.t('date.formats.time_format'))
    end

    def end_time
      object.end_date.strftime(I18n.t('date.formats.time_format'))
    end

    def price
      '%g' % Entries::EntryService.new.get_price(object)
    end
  end
end
