node.override["ntp"]["servers"] = [
  "0.north-america.pool.ntp.org",
  "1.north-america.pool.ntp.org",
  "2.north-america.pool.ntp.org",
  "3.north-america.pool.ntp.org"
]

node.override["php5"]["engine"] = 1
node.override["php5"]["short_open_tag"] = 0
node.override["php5"]["asp_tags"] = 0
node.override["php5"]["precision"] = 12
node.override["php5"]["output_buffering"] = 0
node.override["php5"]["serialzie_precision"] = 100
node.override["php5"]["resource_limits"]["memory_limit"] = "196M"
node.override["php5"]["resource_limits"]["max_execution_time"] = 30
node.override["php5"]["error_handling"]["display_errors"] = 0
node.override["php5"]["error_handling"]["error_reporting"] = -1
node.override["php5"]["error_handling"]["html_errors"] = 1
node.override["php5"]["error_handling"]["log_errors"] = 1
node.override["php5"]["data_handling"]["post_max_size"] = "1024M"
node.override["php5"]["file_uploads"]["file_uploads"] = 1
node.override["php5"]["file_uploads"]["upload_max_fileize"] = "1024M"
node.override["php5"]["cli"]["error_handling"]["error_reporting"] = 0
node.override["php5"]["cli"]["error_handling"]["display_errors"] = 0
node.override["php5"]["cli"]["error_handling"]["html_errors"] = 1
node.override["php5"]["cli"]["error_handling"]["log_errors"] = 1
node.override["php5"]["timezone"] = "America/Chicago"