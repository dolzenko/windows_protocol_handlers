## Windows Protocol Handlers

All the crazy plumbing code you need to get `txmt://open?url=file:////dir/file.rb`
links working on Windows. Can run GVim, Notepad++, Notepad2, Notepad.

## (Ugly) Details

`ProtocolHandlerWrapper.exe` is registered to handle all kinds of protocols
(`txmt`, etc). It finds `ruby.exe` in `PATH` and then executes
`protocol_handler.rb` passing whatever arguments to it which in turn selects
editor (or any other application) to run based on the URI. 

## Installation

Register `ProtocolHandlerWrapper.exe` to handle protocol (`txmt` by default)

    > ruby register_protocol_handler_wrapper.rb [protocol]

Hack `protocol_handler.rb` to customize editor, paths, or add logic for other
protocols.

    > build_wrapper_here.bat

Will build `ProtocolHandlerWrapper.exe` in top directory. Use if you want to
debug wrapper or add any kind of login on the wrapper level.