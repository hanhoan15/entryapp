module Entries
  class EntryService
    SECOND_IN_HOUR = 3600
    EARLY = :early
    LATELY = :lately
    TIME_RANGE = {
      Monday: {early: 7, lately: 19},
      Tuesday: {early: 5, lately: 17},
      Wednesday: {early: 7, lately: 19},
      Thursday: {early: 5, lately: 17},
      Friday: {early: 7, lately: 19},
      Saturday: {early: 0, lately: 0},
      Sunday: {early: 0, lately: 0},
    }
    REGULAR = :regular
    OUTSIDE = :outside
    PRICE = {
      Monday: {regular: 22, outside: 34},
      Tuesday: {regular: 25, outside: 35},
      Wednesday: {regular: 22, outside: 34},
      Thursday: {regular: 25, outside: 35},
      Friday: {regular: 22, outside: 34},
      Saturday: {regular: 47, outside: 47},
      Sunday: {regular: 47, outside: 47},
    }

    def parse_timesheet_entry_info(attributes)
      get_time attributes
      remove_date_params attributes
      attributes
    end

    def get_price(entry)
      price = 0
      beginning_of_day, end_of_day = get_day_boundary(entry)
      price += get_early_price(entry.start_date, entry.end_date, beginning_of_day)
      price += get_lately_price(entry.start_date, entry.end_date, end_of_day)
      price += get_regular_price(entry.start_date, entry.end_date, beginning_of_day, end_of_day)
      price.round(2)
    end

    private
    # parse_timesheet_entry_info
    def get_time(attributes)
      set_start_date attributes
      set_end_date attributes
    end

    def set_start_date(attributes)
      attributes["start_date"] = format_date attributes['date'], attributes['start_time']
    end

    def set_end_date(attributes)
      attributes["end_date"] = format_date attributes['date'], attributes['finish_time']
    end

    def format_date(date, time)
      Time.zone.strptime(
        "#{date} #{time}",
        "#{I18n.t('date.formats.datepicker_date_format')} #{I18n.t('date.formats.datepicker_time_format')}")
    rescue
      raise EntryError
    end

    def remove_date_params(attributes)
      attributes.delete(:date)
      attributes.delete(:start_time)
      attributes.delete(:finish_time)
      attributes
    end

    # get_price
    def date_to_sym(date)
      date.strftime('%A').to_sym
    end

    def get_day_boundary(entry)
      day_of_week = date_to_sym(entry.start_date)
      [entry.start_date.to_date.beginning_of_day + TIME_RANGE[day_of_week][EARLY].hours, entry.start_date.to_date.beginning_of_day + TIME_RANGE[day_of_week][LATELY].hours]
    end

    def get_price_by_range(start_time, end_time, time_range)
      day_of_week = date_to_sym(start_time)
      using_time = (end_time - start_time)/SECOND_IN_HOUR
      using_time * PRICE[day_of_week][time_range]
    end

    def get_early_price(start_time, end_time, early_time)
      return 0 if start_time > early_time
      end_time = early_time if end_time > early_time
      get_price_by_range(start_time, end_time, OUTSIDE)
    end

    def get_lately_price(start_time, end_time, lately_time)
      return 0 if end_time < lately_time
      start_time = lately_time if start_time < lately_time
      get_price_by_range(start_time, end_time, OUTSIDE)
    end

    def get_regular_price(start_time, end_time, early_time, lately_time)
      return 0 if end_time < early_time || start_time > lately_time
      if start_time < early_time
        start_time = early_time
      end
      if end_time > lately_time
        end_time = lately_time
      end
      get_price_by_range(start_time, end_time, REGULAR)
    end
  end
end
