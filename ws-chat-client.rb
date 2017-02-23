require 'websocket-client-simple'
require 'io/console'

url = ARGV.shift || 'ws://192.168.5.68:8080'
ws = WebSocket::Client::Simple.connect url

ws.on :message do |msg|
  print "\r"
  puts msg
end

ws.on :open do
end

ws.on :close do |e|
  p e
  exit 1
end

ws.on :error do |e|
  p e
  puts "Something went wrong (perhaps the server is no longer running?). Exiting..."
  exit -1
end

loop do
  ws.send STDIN.noecho(&:gets)
end
