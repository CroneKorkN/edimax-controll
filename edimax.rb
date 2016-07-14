#!//usr/bin/ruby

if ARGV[0] == "on"
  p `curl -d @on.xml http://admin:1234@10.0.0.127:10000/smartplug.cgi`
elsif ARGV[0] == "off"
  p `curl -d @off.xml http://admin:1234@10.0.0.127:10000/smartplug.cgi`  
elsif ARGV[0] == "usage"
  p `curl -d @usage.xml http://admin:1234@10.0.0.127:10000/smartplug.cgi`.scan(/<Device.System.Power.NowPower>(.*)<\/Device.System.Power.NowPower>/)[0][0]
end