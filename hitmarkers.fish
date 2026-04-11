function play_sound_cue
    paplay --volume=32768 $argv[1] 2> /dev/null & disown
end

set -g __postexec_blacklist vim man info perldoc
set -g __term_hitmarker_script_dir (dirname (realpath (status filename)))

function postexec_sound --on-event fish_postexec
    set saved_status $status
    echo $argv | read -la last_cmd

    if test $saved_status -ne 0
        play_sound_cue "$__term_hitmarker_script_dir/term-hitmarker-error"
        return
    end

    for cmd in $__postexec_blacklist
        if test "$last_cmd[1]" = "$cmd"
            return
        end
    end

    play_sound_cue "$__term_hitmarker_script_dir/term-hitmarker-hit"
end
