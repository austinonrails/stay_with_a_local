hosts = YAML.load(File.read(File.join(File.dirname(__FILE__), "hosts.yml")))
hosts.each do |h|
  host = Host.create h
end

guests = File.read(File.join(File.dirname(__FILE__), "guests.txt"))
guests.each do |line|
  begin
    name, twitter = line.split('@')
    unless twitter.to_s.strip == ''
      Guest.create :name => name.to_s.strip, :twitter => twitter.to_s.strip
    end
  rescue Exception => ex
    puts "Problem with #{line}: #{ex.class} - #{ex.message}"
  end
end

rr = RoomRequest.create(:host => Host.first, :guest => Guest.first)
rr.accept

RoomRequest.create(:host => Host.last, :guest => Guest.last).accept
