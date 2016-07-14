# edimax-controll

tools to use EDIMAX SP-2101W without phoning home

## cron

'/etc/cron.d/edimax-controll' fills the databse

```
*/5 *    * * *  www-data  /var/www/edimax-controll/collect.rb > /dev/null 2>&1

```

'/etc/cron.daily/edimax-controll' notifies ones a day

```
#!/bin/sh

/var/www/edimax-controll/notify.rb

```