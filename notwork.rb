#!/usr/bin/ruby

time = Time.now

speedtest = `./speedtest-cli --simple`
p speedtest

speedtest.split("\n").each do |line|
  if matchdata = /^([[:alpha:]]+): ([[:digit:]\.]+)/.match(line)
    metric = matchdata[1]
    value = matchdata[2]
    p "./librato-guage 'notwork.speedtest.#{metric}' #{value} #{time.to_i}"
    `./librato-guage 'notwork.speedtest.#{metric}' #{value} #{time.to_i}`
  end
end
