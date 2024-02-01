require "date_range_formatter"

RSpec.describe(DateRangeFormatter) do
  context 'when formatting the same day' do
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

    it "formats a date range for the same day but different month and different year" do
      formatter = DateRangeFormatter.new("2009-11-1", "2010-12-1")
      expect(formatter.to_s).to eq("1st November 2009 - 1st December 2010")
    end
  end

  context 'when formatting the same month' do
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

    it "formats a date range for the same month but different year " do
      formatter = DateRangeFormatter.new("2009-11-1", "2010-11-3")
      expect(formatter.to_s).to eq("1st November 2009 - 3rd November 2010")
    end

    it "formats a date range for the same month but different year with time" do
      formatter = DateRangeFormatter.new("2009-11-1", "2010-11-3", "10:00", "10:00")
      expect(formatter.to_s).to eq("1st November 2009 at 10:00 - 3rd November 2010 at 10:00")
    end
  end

  context 'when formatting the same year' do
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

  context 'when formatting the different year' do
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
  end

  it "formats a start day after the end day" do
    formatter = DateRangeFormatter.new("2009-12-1", "2009-11-1")
    expect(formatter.to_s).to eq("1st December - 1st November 2009")
  end

  it "passes DD-MM-YYYY date format" do
    formatter = DateRangeFormatter.new("1-11-2009", "1-12-2009")
    expect(formatter.to_s).to eq("1st November - 1st December 2009")
  end

  it "passes DD/MM/YYYY date format" do
    formatter = DateRangeFormatter.new("1/11/2009", "1/12/2009")
    expect(formatter.to_s).to eq("1st November - 1st December 2009")
  end

  it "passes incorrect date format" do
    expect do
      DateRangeFormatter.new("1-13-2009", "1-14-2009")
    end.to raise_error Date::Error, "invalid date"
  end

  it "passes timestamp date format" do
    formatter = DateRangeFormatter.new("20220705", "20230705", "15h23m24s")
    expect(formatter.to_s).to eq("5th July 2022 at 15h23m24s - 5th July 2023")
  end
end

