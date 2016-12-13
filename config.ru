# HerokuはDB接続を自動でコネクションを切断しないため、数回（5回？）のアクセスで、
# ActiveRecord::ConnectionTimeoutErrorが発生して、Internal Server Errorとなる。
# ソース内でconnectionを切断するように設定する必要あり。
# ひとまず、config.ruにActiveRecord::ConnectionAdapters::ConnectionManagementを読み込ませておくと解決する。
# 詳細は勉強中です。
# http://qiita.com/myokkie/items/6f65db5d53f19d34a27c
require_relative 'app'

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Api::Application
