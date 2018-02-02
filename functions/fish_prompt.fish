function fish_prompt
  set -l prev_status $status

  set -l cred (set_color red)
  set -l cblue (set_color blue)
  set -l cyellow (set_color yellow)
  set -l cgreen (set_color green)
  set -l cnormal (set_color normal)

  set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  set -g __fish_prompt_char \$

  set -l exit_status $cred(printf '%3d' $prev_status)$cnormal
  set -l pwd $cgreen(prompt_pwd)$cnormal
  set -l user_host $cyellow$USER@$__fish_prompt_hostname$cnormal

  set -l prompt "$exit_status $user_host:$pwd"

  # set -l ve ""
  # if set -q VIRTUAL_ENV
  #   set ve (printf "(%s)" (basename $VIRTUAL_ENV))
  # end

  if test "$CMD_DURATION" -gt 100
    set -l duration $cblue(echo $CMD_DURATION | humanize_duration)$cnormal
    set prompt "$prompt $duration"
  end

  set prompt "$prompt\n$__fish_prompt_char "

  printf $prompt
end
