require "date_range_formatter"

RSpec.describe(DateRangeFormatter) do
  it 'raises an error when clients provide a malformed date' do
    expect { DateRangeFormatter.new("2009-11q-1o", "2009-11-1") }.to raise_error(Date::Error)
  end

  it 'raises an error when clients provide malformed times' do
    pending('To discuss with client of code')
    expect { DateRangeFormatter.new("2009-11-1", "2024-11-1", "-01-00", "02-00") }.to raise_error
  end

  it 'raises an error when clients do not provide dates as strings' do
    expect { DateRangeFormatter.new(482934823984, 99869586956543434) }.to raise_error(TypeError)
  end

  it 'formats a date range even when the start date is after the end date' do
    formatter = DateRangeFormatter.new("2010-11-1", "2009-11-1")
    expect(formatter.to_s).to eq("1st November 2010 - 1st November 2009")
  end

  it 'formats a date range even when the start time is after the end time' do
    formatter = DateRangeFormatter.new("2009-11-1", "2009-11-1", "13:00", "11:00")
    expect(formatter.to_s).to eq("1st November 2009 at 13:00 to 11:00")
  end

  it 'does not formats a date range dates are not provided' do
    expect { DateRangeFormatter.new(nil, "2009-11-1", "13:00", "11:00") }.to raise_error
    expect { DateRangeFormatter.new("2021-03-22", nil, "13:00", "11:00") }.to raise_error
  end

  {
    'YYYY/mm/dd' => "2009/10/2",
    'YY-mm-dd' => "09/10/2",
    'YYYY.mm.dd' => '2009.10.2'
  }.each do |format, date|
    it "does not format a date range for the same day when the date has format is #{format} e.g. #{date}" do
      formatter = DateRangeFormatter.new(date, date, "11:00", "12:00")
      expect(formatter.to_s).to eq("2nd October 2009 at 11:00 to 12:00")
    end
  end

  context 'when dates are the same' do
    it "formats a date range for the same day" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-11-1")
      expect(formatter.to_s).to eq("1st November 2009")
    end

    it "formats a date range for the same day with starting time" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-11-1", "10:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00")
    end

    it "formats a date range for the same day with starting and ending times" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-11-1", "10:00", "11:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 to 11:00")
    end

    it "formats a date range for the same day with only ending times" do
      formatter = DateRangeFormatter.new("2009-1-1", "2009-1-1", nil, "11:00")
      expect(formatter.to_s).to eq("1st January 2009 until 11:00")
    end
  end

  context 'When the year AND months are the same' do
    it "formats a date range for the same month" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-11-3")
      expect(formatter.to_s).to eq("1st - 3rd November 2009")
    end

    it "formats a date range for the same month with starting time" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-11-3", "10:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 - 3rd November 2009")
    end

    it "formats a date range for the same month with starting and ending times" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-11-3", "10:00", "11:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 - 3rd November 2009 at 11:00")
    end
  end

  context 'when the years are the same but the months are different' do
    it "formats a date range for the same year" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-12-1")
      expect(formatter.to_s).to eq("1st November - 1st December 2009")
    end

    it "formats a date range for the same year with starting time" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-12-1", "10:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 - 1st December 2009")
    end

    it "formats a date range for the same year with starting and ending times" do
      formatter = DateRangeFormatter.new("2009-11-1", "2009-12-1", "10:00", "11:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 - 1st December 2009 at 11:00")
    end
  end

  context 'when the years are different' do
    it "formats a date range for different year" do
      formatter = DateRangeFormatter.new("2009-11-1", "2010-12-1")
      expect(formatter.to_s).to eq("1st November 2009 - 1st December 2010")
    end

    it "formats a date range for different year with starting time" do
      formatter = DateRangeFormatter.new("2009-11-1", "2010-12-1", "10:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 - 1st December 2010")
    end

    it "formats a date range for different year with starting and ending times" do
      formatter = DateRangeFormatter.new("2009-11-1", "2010-12-1", "10:00", "11:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 - 1st December 2010 at 11:00")
    end

    it 'formats a date range for the same month in different years' do
      formatter = DateRangeFormatter.new("2009-11-1", "2010-11-3")
      expect(formatter.to_s).to eq("1st November 2009 - 3rd November 2010")
    end
  end
end

