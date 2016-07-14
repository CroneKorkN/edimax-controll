#!/usr/bin/ruby

require "cgi"
cgi = CGI.new
puts cgi.header
ip = File.read("/var/www/ddns/ip.txt")

#p ip
#p "curl -d @status.xml http://admin:1234@#{ip}:10000/smartplug.cgi"

status = `curl -d @status.xml http://admin:1234@#{ip}:10000/smartplug.cgi`.scan(/<Device.System.Power.State>(.*)<\/Device.System.Power.State>/)[0][0] == "ON" ? true : false
usage = `curl -d @usage.xml http://admin:1234@#{ip}:10000/smartplug.cgi`.scan(/<Device.System.Power.NowPower>(.*)<\/Device.System.Power.NowPower>/)[0][0].to_f

p "is #{status}"

if cgi.params["toggle"]
	if cgi.params["toggle"][0] == "true"
		p `curl -d @on.xml http://admin:1234@#{ip}:10000/smartplug.cgi`
	elsif cgi.params["toggle"][0] == "false"
		p `curl -d @off.xml http://admin:1234@#{ip}:10000/smartplug.cgi` 
	end
end

puts "
<p>
	usage: #{usage}
</p>
<form method=post action=''>
	<input type=hidden name=toggle value=#{(status == false)}>
	<input type=submit value=#{(status == false)}>
</form>
"
