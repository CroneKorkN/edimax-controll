#!/usr/bin/ruby

require "mail"
require "mysql2"

db = Mysql2::Client.new(:host => "localhost", :username => "edimax-controll", password: "tPY6rfRbJcULLrQJ", database: "edimax-controll")
result = db.query "SELECT SUM(WATTS) AS sum, count(*) AS count FROM wattages WHERE datetime > '#{DateTime.now - (24/24.0)}'"
kwh = 0.0
cost = 0.0
result.each do |row|
  kwh = row["sum"].to_f / row["count"].to_i * 24 / 1000
  cost = kwh * 0.23
end

Mail.defaults do
  delivery_method :smtp, address: "mail.sublimity.de", user_name: "edimax-controll@sublimity.de", password: "edimax-controll"
end

["i@ckn.li", "nadja@wettengl.net"].each do |address|
  Mail.deliver do
    from    'edimax-controll@sublimity.de'
    to      address
    subject "#{cost.round(2)} € yesterday"
    body    "#{kwh.round(2)} KWh (#{cost.round(2)} €) in the last 24 hours"
  end
end