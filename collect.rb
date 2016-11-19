#!/usr/bin/ruby

require "mysql2"
ip = "10.0.0.127" #File.read("/var/www/ddns/ip.txt")

db = Mysql2::Client.new(:host => "localhost", :username => "edimax-controll", password: "tPY6rfRbJcULLrQJ", database: "edimax-controll")

usage = `curl -d @/var/www/edimax-controll/usage.xml http://admin:1234@#{ip}:10000/smartplug.cgi`.scan(/<Device.System.Power.NowPower>(.*)<\/Device.System.Power.NowPower>/)[0][0].to_f

db.query "
INSERT INTO wattages
SET
  watts  = #{usage},
  datetime = '#{Time.now}'
"
