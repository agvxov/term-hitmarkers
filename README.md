# Terminal Hitmarkers

> ~~Autistic~~ Acoustic feedback for shell command exit statuses

Every time a command exits, a short sound cue will be played.
On success it sounds like a hitmarker,
otherwise it sounds like an error.

The ideal hitmarker is exactly like [this](documentation/hitmarkers.mkv),
but the best your terminal can handle is right here.

You will either love it or hate it, nothing in between.

## Installation
### Bash
Source or copy the contents of `hitmarkers.bash` into your Bashrc.
### Fish
Source or copy the contents of `hitmarkers.fish` into your Fish config.
### Zsh
There is no implementation and I am personally not making one.

## Implementation notes
The shell scripts are stand alone, this is crucial.
This is accomplished with the help of `./mk-sound-vars.pl`, `./Makefile`
and [Plug](https://github.com/agvxov/plug.git),
that embed files from `data/` in base64.
To minimize latency,
the base64 encoding is extracted into `/dev/shm/` on startup
(yes, it makes an audible difference).

Speaking of audible difference,
don't bother running with under WSL,
the latency is horrificly large.

If you wish to use your own sound files,
you could change the paths in `mk-sound-vars.pl`,
install Plug and invoke `make`;
or you may create a base64 dump of your files and insert them by hand
(just make sure to remove newlines).
