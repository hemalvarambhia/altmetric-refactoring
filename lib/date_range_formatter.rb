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
    full_start_date = @start_date.strftime("#{@start_date.day.ordinalize} %B %Y")
    full_end_date = @end_date.strftime("#{@end_date.day.ordinalize} %B %Y")

    if @start_time && @end_time
      return "#{full_start_date} at #{@start_time} to #{@end_time}" if same_date?
      "#{full_start_date} at #{@start_time} - #{full_end_date} at #{@end_time}"
    elsif @start_time
      return "#{full_start_date} at #{@start_time}" if same_date?
      "#{full_start_date} at #{@start_time} - #{full_end_date}"
    elsif @end_time
      return "#{full_start_date} until #{@end_time}" if same_date?
      "#{full_start_date} - #{full_end_date} at #{@end_time}"
    else
      return full_start_date if same_date?
      if @start_date.month == @end_date.month
        if @start_date.year == @end_date.year
          return @start_date.strftime("#{@start_date.day.ordinalize} - #{@end_date.day.ordinalize} %B %Y")
        end
      elsif @start_date.year == @end_date.year
        return @start_date.strftime("#{@start_date.day.ordinalize} %B") + " - " + @end_date.strftime("#{@end_date.day.ordinalize} %B %Y")
      end

      "#{full_start_date} - #{full_end_date}"
    end
  end

  private

  def same_date?
    @start_date == @end_date
  end
end

