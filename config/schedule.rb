# use bundle exec whenever --update-crontab and whenever --clear-crontab

# File.expand_path(File.dirname(__FILE__) + "/environment")
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# 絶対パスから相対パス指定
env :PATH, ENV['PATH']
# ログファイルの出力先
set :output, 'log/cron.log'
# ジョブの実行環境の指定
set :environment, :development
# Example:
#
every 1.days, at: '15:40 pm' do
  runner "DailyMailer.daily_mail.deliver_now"
end

# every 1.minutes do
#   runner "DailyMailer.daily_mail.deliver_now"
# end

# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
