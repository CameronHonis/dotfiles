# Design

In this file, I lay out all (after May 17, 2025) design decisions.

This will probably be mostly comprised of comparing the tradeoffs of various 
plugins.

# Remote Dev Plugins
**Goal:** To provide the lowest friction workflow developing on a remote machine

**Selection:**
    1. [distant.nvim](https://github.com/chipsenkbeil/distant.nvim)
    1. [remote-nvim.nvim](https://github.com/amitds1997/remote-nvim.nvim?tab=readme-ov-file)
    1. [nvrh (neovim remote helper)](https://github.com/mikew/nvrh)

I ended up checking out `remote-nvim.nvim` first because it seemed like the
lowest complexity to start, both on first and subsequent attempts. 

`distant.nvim` was a close second, however, it required installation of another 
tool `distant` on the remote machine as well as the client.

`nvrh` seemed like the worst of the three options because it was the only plugin
that required setup of tunnel ports before being able to connect. Additionally,
this plugin showed weak community adoption/support on github.

after some reading up on `remote-nvim.nvim`, I decided not to explore this
plugin further due to the fact that this plugin essentially provides a
convenient way to spin up and mirror a neovim clone of your local version. This
is bad because it eats at remote resources and also is susceptible to
performance degredation in the case the network connection between local and
remote is not fast and reliable.

`distant.nvim` appears to work in a different manner. This plugin appeared
promising except for the fact that it doesn't seem like it would integrate well
with my current workflow. For example, to open a file on remote, I would need to
call `:DistantOpen /path/to/remote/file` on local machine. Since this is the
only way to open remote files, I couldn't use telescope, as an example. I
anticipate there are many other hiccups that occur due to editing on a file
system that is not locally synced.

This leads me to believe that the best system is a locally-synced fs. The issue
here is that any commands ran in the neovim terminal would execute locally,
which can be confusing if working on a project that is intended to be ran
remotely. The solution obvious solution is to break the habit of running remote
commands in the neovim terminal and just use another tmux pane to ssh into the
remote and execute commands there. Maybe there is a clever feature I could
implement into floaterminal that would allow me to forward commands through ssh
to the remote with some fancy project-location-awareness, but for now, the easy
answer is to just use bare ssh in a separate terminal session.

conveniently, this doesnt require any plugins. turns out, linux natively ships
my exact needs, not with syncing, but with mounting a file system. The tricky
part is that sharing executables (i.e. interpreters) can cause issues with
cross-compatibility. The only solution I found so far is to maintain two
separate executable environments (venvs, in python).
