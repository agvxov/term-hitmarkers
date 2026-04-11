function play_sound_cue
    paplay --volume=32768 $argv[1] 2> /dev/null & disown
end

set -g __postexec_blacklist vim man info perldoc

function postexec_sound --on-event fish_postexec
    set saved_status $status
    echo $argv | read -la last_cmd

    if test $saved_status -ne 0
        play_sound_cue "/home/anon/stow/.data/windows-7-error-cue.mp3"
        return
    end

    for cmd in $__postexec_blacklist
        if test "$last_cmd[1]" = "$cmd"
            return
        end
    end

    #set elapsed (math (date +%s) - $__cmd_start_time)

    play_sound_cue "/home/anon/stow/.data/tf2-hit-cue.wav"
end
