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
  puts "*** CLOSING ***"
  p e
  exit 1
end

ws.on :error do |e|
  #TODO add attempt reconnect if error is server disconnected
  p e
  puts "Something went wrong (perhaps the server is no longer running?). Exiting..."
  exit -1
end

loop do
  #to see bits of what you are typing swap comment on following two lines
  # ws.send gets
  ws.send STDIN.noecho(&:gets)
end
