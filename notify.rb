#!/usr/bin/ruby

require "mail"
require "mysql2"

db = Mysql2::Client.new(:host => "localhost", :username => "edimax-controll", password: "", database: "edimax-controll")
result = db.query "SELECT SUM(WATTS) AS sum, count(*) AS count FROM wattages WHERE datetime > '#{DateTime.now - (24/24.0)}'"
watts = 0.0
result.each do |row|
  watts = row["sum"].to_f / row["count"].to_i
end

Mail.defaults do
  delivery_method :smtp, address: "mail.sublimity.de", user_name: "edimax-controll@sublimity.de", password: ""
end

["i@ckn.li", "nadja@wettengl.net"].each do |address|
  Mail.deliver do
    from    'edimax-controll@sublimity.de'
    to      address
    subject "#{watts} watts"
    body    "#{watts} watts averagely in the last 24 hours"
  end
end