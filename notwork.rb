speedtest = `./speedtest-cli --simple`
require 'net/http'

# speedtest = "Ping: 68.746 ms\nDownload: 0.97 Mbit/s\nUpload: 0.00 Mbit/s\n"
p speedtest

def simple_librato_post metric, value

  `curl  \
    -u langer8191@gmail.com:e9b6f613e449af1463a39fba60ff1d9545ade736564ca2a18a2a298a08d39d58 \
    -d 'gauges[0][name]=#{metric}' \
    -d 'gauges[0][value]=#{value}' \
    -d 'gauges[0][source]=macbook' \
    -X POST \
    https://metrics-api.librato.com/v1/metrics`
  # uri = URI('https://langer8191%40gmail.com:e9b6f613e449af1463a39fba60ff1d9545ade736564ca2a18a2a298a08d39d58@metrics-api.librato.com/v1/metrics')
  # p uri.userinfo
  # # post = Net::HTTP.Post.new(uri)
  # # post.basic_auth(', 'e9b6f613e449af1463a39fba60ff1d9545ade736564ca2a18a2a298a08d39d58')

  # p Net::HTTP.post_form(uri, 'gauges[0][name]' =>  metric, 'gauges[0][value]' => value)
end

speedtest.split("\n").each do |line|
  if matchdata = /^([[:alpha:]]+): ([[:digit:]\.]+)/.match(line)
    metric = matchdata[1]
    value = matchdata[2]
    simple_librato_post "notwork.#{metric}", value
  end
end

