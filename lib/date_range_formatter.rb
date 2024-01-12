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
    if same_date?
      return "#{formatted(@start_date, at: @start_time)} to #{@end_time}" if @start_time && @end_time
      return "#{formatted(@start_date, at: @start_time)}" if @start_time
      return "#{in_full(@start_date)} until #{@end_time}" if @end_time
      in_full(@start_date)
    else
      return "#{formatted(@start_date, at: @start_time)} - #{formatted(@end_date, at: @end_time)}" if @start_time && @end_time
      return "#{formatted(@start_date, at: @start_time)} - #{in_full(@end_date)}" if @start_time
      return "#{in_full(@start_date)} - #{formatted(@end_date, at: @end_time)}" if @end_time
      if same_year?
        return "#{@start_date.day.ordinalize}" + " - " + in_full(@end_date) if same_month?
        return @start_date.strftime("#{@start_date.day.ordinalize} %B") + " - " + in_full(@end_date)
      end

      "#{in_full(@start_date)} - #{in_full(@end_date)}"
    end
  end

  private

  def formatted(date, at:)
    format = "%s at %s"
    sprintf(format, in_full(date), at)
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

