prefix = File.dirname(__FILE__) + "/"
$LOAD_PATH.unshift prefix

Dir.glob(prefix + "**/*.rb").each do |f|
  require File.expand_path(f)
end
