# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
 every 5.minutes do
   runner "ScheduledConnecting.new.process"
 end
 every 3.minutes do
   runner "TrackDataImageUpdater.new.process"
 end
