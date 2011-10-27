require "rubygems"
require "erb"

app  = ARGV[0] || "txmt"
path = ARGV[1] || File.expand_path("..\\ProtocolHandlerWrapper.exe", __FILE__)
path = path.gsub(/[\\\/]/, "\\\\\\\\")
ruby = Gem.ruby.gsub(/[\\\/]/, "\\\\\\\\")

reg = ERB.new(IO.read("register_protocol_handler_wrapper.reg.erb")).result(binding)
reg_path = File.expand_path("../register_protocol_handler_wrapper.reg", __FILE__)
File.open(reg_path, "w") { |f| f.write(reg) }
system("cmd /c regedit #{reg_path}")