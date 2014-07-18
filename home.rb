require 'rss'
require 'open-uri'
require 'action_view'

include ActionView::Helpers::DateHelper

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
  user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36'

  open(ottoa_url, 'User-Agent' => user_agent) do |rss|
    ottoa_feed = RSS::Parser.parse(rss)
    @ottoa = []

    ottoa_feed.items.each do |item|
      route_grade_crag = item.description.split('<br>').at(0).split(',')
      route_grade = route_grade_crag.at(0)
      route = route_grade[0..-4].strip
      grade = route_grade[-3, 3].strip
      crag = route_grade_crag.at(1).strip

      @ottoa.push({route: route, grade: grade, crag: crag, date: time_ago_in_words(item.pubDate) + ' ago'})
    end
  end

  haml :index
end
