require "rubygems"
require "erb"

if ARGV.empty?
  puts <<-TEXT
Usage: #{$0} PROTOCOL [PATH]+"

Registers a PROTOCOL on registry that will execute the command given by PATH. Several PATHs can be given which means they will all be properly quoted and passed down to the register. For example, you can register a Ruby to be executed as:

    register_protocol_handler.rb txmt C:\\Ruby187\\bin\\ruby.exe C:\\txmt.rb

Since registering a RUBY script is common, you may also pass:

    register_protocol_handler.rb txmt RUBY C:\\txmt.rb

With the same effect as above.
  TEXT
else
  args = ARGV.dup
  app  = args.shift

  args.map! do |raw|
    path = (raw == "RUBY" ? Gem.ruby : File.expand_path(raw, Dir.pwd))
    %[\\"#{path.gsub(/[\\\/]/, "\\\\\\\\")}\\"]
  end

  reg = ERB.new(IO.read("register_protocol_handler.reg.erb")).result(binding)
  reg_path = File.expand_path("../register_protocol_handler.reg", __FILE__)
  File.open(reg_path, "w") { |f| f.write(reg) }
  system("cmd /c regedit #{reg_path}")
end