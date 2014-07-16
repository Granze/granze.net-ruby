require 'rss'
require 'open-uri'

get '/' do
  lastfm_url = 'http://ws.audioscrobbler.com/1.0/user/granzebru/recenttracks.rss'
  open(lastfm_url) do |rss|
    @lastfm_feed = RSS::Parser.parse(rss)
  end

  github_url = 'https://github.com/Granze.atom'
  open(github_url) do |rss|
    @github_feed = RSS::Parser.parse(rss)
  end

  ottoa_url = 'http://www.8a.nu/rss/Main.aspx?UserId=19212&AscentType=0&ObjectClass=2&GID=3974d72911c05719152f0953e88cc2df'
  open(ottoa_url) do |rss|
    @ottoa_feed = RSS::Parser.parse(rss)
  end

  haml :index
end
