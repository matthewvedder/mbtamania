class FeedsController < ApplicationController

  def feed
    @feed = remove_timestamp_and_lateness(departure(Feed.first.convert_arrival_time))
  end

  def remove_timestamp_and_lateness(data)
    data.each do |i|
      i.delete_at(0)
      i.delete_at(4)
    end
  end

  # call before remove_timestamp_and_lateness
  def departure(data)
    data[0][4] = "Departure"
    data
  end
end
