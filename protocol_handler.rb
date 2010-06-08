# return local path from path in txmt protocol
def map_path(txmt_path)
  txmt_path.sub("/mnt/hgfs/ubuntu_shared/", "C:/Users/work/Documents/ubuntu_shared/")
end

def spawn_notepadpp(path, line = 0, col = 0)
  cmd = ['start ""', 'notepad++.exe', "-n#{line}", "-c#{col}", path].join(" ")
  system(cmd)
end

def spawn_notepad(path, line = 0, col = 0)
  cmd = ['start ""', 'notepad.exe', path].join(" ")
  system(cmd)
end

def spawn_notepad2(path, line = 0, col = 0)
  cmd = ['start ""', 'Notepad2.exe', "/g", line, path].join(" ")
  system(cmd)
end

def spawn_vim(path, line = 0, col = 0)
  cmd = ['start ""', '"C:\Program Files (x86)\Vim\vim72\gvim.exe"', "--remote", "+#{line}", path].join(" ")
  system(cmd)
end

alias spawn_editor spawn_notepadpp

begin
  uri = ARGV.join(" ")

  # File.open(File.expand_path("../argv", __FILE__), "w") { |f| f.write(ARGV.inspect) }

  path, line, col = uri.scan(/txmt:\/\/open\/?\?url=file:\/\/(.+?)&line=(\d+)&column=(\d+)/)[0]
  path = map_path(path)
  spawn_editor(path, line, col)
rescue Exception => e
  log_path = File.expand_path("../protocol_handler.log", __FILE__)
  File.open(log_path, "w") { |f| f.write(["Failed to open #{ uri }:", e.message, e.backtrace.join("\n")].join("\n")) }
  spawn_notepad(log_path)
end