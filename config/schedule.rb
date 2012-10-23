set :output, "log/cron_log.log"
set :environment,"development"
every 30.minute do
         rake "backup"
       end
