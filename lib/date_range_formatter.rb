require "date"
require "integer"

class DateRangeFormatter
  def initialize(start_date, end_date, start_time = nil, end_time = nil)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @start_time = start_time
    @end_time = end_time
  end

  def to_s
    full_start_date = in_full(@start_date)
    full_end_date = in_full(@end_date)
    format = "%s at %s"
    if same_date?
      return "#{formatted(full_start_date, @start_time)} to #{@end_time}" if @start_time && @end_time
      return "#{formatted(full_start_date, @start_time)}" if @start_time
      return "#{full_start_date} until #{@end_time}" if @end_time
      return full_start_date if @start_time.nil? && @end_time.nil?
    else
      return "#{formatted(full_start_date, @start_time)} - #{full_end_date} at #{@end_time}" if @start_time && @end_time
      return "#{formatted(full_start_date, @start_time)} - #{full_end_date}" if @start_time
      return "#{full_start_date} - #{full_end_date} at #{@end_time}" if @end_time
      if same_year?
        return @start_date.strftime("#{@start_date.day.ordinalize} - #{@end_date.day.ordinalize} %B %Y") if same_month?
        return @start_date.strftime("#{@start_date.day.ordinalize} %B") + " - " + in_full(@end_date)
      end

      "#{full_start_date} - #{full_end_date}"
    end
  end

  private

  def formatted(date, time)
    format = "%s at %s"
    sprintf(format, date, time)
  end

  def in_full(date)
    date.strftime("#{date.day.ordinalize} %B %Y")
  end

  def same_month?
    @start_date.month == @end_date.month
  end

  def same_year?
    @start_date.year == @end_date.year
  end

  def same_date?
    @start_date == @end_date
  end
end

