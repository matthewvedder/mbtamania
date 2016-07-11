require 'mechanize'
require 'csv'

class ScrapeJob < ApplicationJob
  queue_as :default

  def perform
    agent = Mechanize.new
    file = agent.get("http://developer.mbta.com/lib/gtrtfs/Departures.csv")
    filename = file.save!("app/assets/data/feed.csv")
    save_feed
    keep_running
  end

  def save_feed
    data = CSV.read('app/assets/data/feed.csv')
    Feed.first.update!(data: data)
  end

  def keep_running
    ScrapeJob.set(wait: 15.seconds).perform_later
  end
end
