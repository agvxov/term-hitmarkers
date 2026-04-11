play_sound_cue() {
    paplay --volume=32768 "$1" >/dev/null 2>&1 & disown
}

# Programs which should not emit any sound
declare -ga __postexec_blacklist=(vim man info perldoc)

# Directory containing this script, using only builtins.
__postexec_src=${BASH_SOURCE[0]}
__postexec_dir=${__postexec_src%/*}
[[ $__postexec_dir == "$__postexec_src" ]] && __postexec_dir=.
__postexec_script_dir=$(
    \cd -P -- "$__postexec_dir" && printf '%s\n' "$PWD"
)
# --

__postexec_prompt_hook() {
    saved_status=$?

    local hist line first cmd

    hist=$(builtin history 1)
    read -r _ _ _ line <<<"$hist"
    [[ -n $line ]] && last_command=$line

    if (( $saved_status != 0 )); then
        play_sound_cue "$__postexec_script_dir/term-hitmarker-error"
        return
    fi

    last_command_argv0=${last_command%%[[:space:]]*}
    for cmd in "${__postexec_blacklist[@]}"; do
        if [[ $last_command_argv0 == "$cmd" ]]; then
            return
        fi
    done

    play_sound_cue "$__postexec_script_dir/term-hitmarker-hit"
}

PROMPT_COMMAND=__postexec_prompt_hook
