require "active_support/core_ext"

class DatePeriod::Month

  include Comparable

  class << self
    def including(datish)
      date = datish.to_date
      new year: date.year, month: date.month
    end

    def current
      including Date.current
    end

    def load(serialized_month)
      data = JSON.load serialized_month
      new year: data["year"], month: data["month"]
    end

    def dump(month)
      JSON.dump("year" => month.year, "month" => month.month)
    end
  end

  attr_reader :year, :month

  def initialize(year: Date.current.year, month: Date.current.month)
    @year = year
    @month = month
  end

  def succ
    self.class.new year: year, month: month + 1
  end
  alias :next :succ

  def prev
    self.class.new year: year, month: month - 1
  end

  def <=>(other)
    [year, month] <=> [other.year, other.month]
  end

  def +(duration)
    self.class.including(first_day + Duration(duration))
  end

  def -(duration)
    self.class.including(first_day - Duration(duration))
  end

  def date_period
    first_day .. ((self + 1).first_day - 1.day)
  end

  def to_date
    first_day
  end

  def eql?(other)
    hash == other.hash
  end

  def first_day
    Date.new(year, month, 1)
  end

  def last_day
    first_day.end_of_month
  end

  def date_period
    first_day .. last_day
  end

  def first_moment(zone: Time.zone)
    Time.use_zone(zone){ first_day.beginning_of_day }
  end

  def last_moment(zone: Time.zone)
    Time.use_zone(zone){ last_day.end_of_day }
  end

  def time_period
    first_moment .. last_moment
  end

  def include?(datish)
    datish.year == year && datish.month == month
  end

  def inspect
    first_day.strftime "%b %Y"
  end

  protected

  def hash
    @hash ||= [self.class, year, month].hash
  end

  private

  def Duration(duration)
    duration.kind_of?(ActiveSupport::Duration) ? duration : duration.month
  end

end
