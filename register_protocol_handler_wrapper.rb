require 'erb'
reg = ERB.new(IO.read("register_protocol_handler_wrapper.reg.erb")).result
reg_path = File.expand_path("../register_protocol_handler_wrapper.reg", __FILE__)
File.open(reg_path, "w") { |f| f.write(reg) }
system("cmd /c regedit #{ reg_path }")