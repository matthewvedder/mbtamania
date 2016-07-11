class Feed < ApplicationRecord
  validates :data, presence: true
  serialize :data

  # call this before without_timestamp
  def convert_arrival_time
    data = self.data
    array_length = data.length - 1

    (1..array_length).each do |i|
      departure = Time.at(data[i][4].to_i)
      hours = departure.hour > 12 ? departure.hour - 12 :  departure.hour
      aligned_hours = hours < 10 ? "0#{hours}" : hours
      minutes = departure.min < 10 ? "0#{departure.min}" : departure.min
      am_pm = departure.hour < 12 ? 'AM' : 'PM'

      data[i][4] = "#{aligned_hours}:#{minutes} #{am_pm}"
    end
    data
  end

end
