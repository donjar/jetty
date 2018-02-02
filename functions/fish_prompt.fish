function fish_prompt
  set -l cred (set_color red)
  set -l cblue (set_color blue)
  set -l cyellow (set_color yellow)
  set -l cgreen (set_color green)
  set -l cnormal (set_color normal)

  set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  set -g __fish_prompt_char "\$"

  set -l exit_status $cred$status$cnormal
  set -l pwd $cgreen(prompt_pwd)$cnormal
  set -l user_host $cyellow$USER@$__fish_prompt_hostname$cnormal
  set -l OS (uname)
  set -l git_output

  if test $OS = "Linux"
    alias ls "ls --color=auto"
  else if test $OS = "Darwin"
    alias ls "ls -G"
  end

  # set -l ve ""
  # if set -q VIRTUAL_ENV
  #   set ve (printf "(%s)" (basename $VIRTUAL_ENV))
  # end

  set -l duration $cblue(echo $CMD_DURATION | humanize_duration)$cnormal
  set right_prompt $right_prompt "$duration "

  printf "$exit_status $user_host:$pwd $duration\n$__fish_prompt_char "
end
