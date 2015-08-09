require 'rss'
require 'pp'
require './wfp_setting'
require 'time'

## getrss.rb
#はてなブログの/rssはRSS2.0を返すとのこと

#rssのdescriptionから画像のURIを出す
def getPicSrc(description)
  arr = description.split(" ")
  arr.each do |e|
    if /^src="(.*)"/ =~ e
      return $1
    end
  end
  return nil
end

#保存ファイル名を求める
#def getFileName
#  t = Time.now
#  r = "wfp" + t.strftime("%Y%m%d") + ".yaml"
#end

uri = RSS_URI
rss = RSS::Parser.parse(uri)
io = open(getYamlFileName, "w")
io.puts '---'
rss.channel.items.each do |i|
  io.puts '- uri: '     + i.link
  io.puts '  title: '   + i.title
  io.puts '  pic_uri: ' + getPicSrc(i.description)
end

