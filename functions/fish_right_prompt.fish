function fish_right_prompt
  set -l right_prompt ""

  # # Check if has Gemfile
  # if git_is_repo
  #   set -l path (git rev-parse --show-toplevel)
  #   set -l git_repository_gemfile_path "$path/Gemfile"

  #   if test -e $git_repository_gemfile_path
  #     set -l rubyv (command ruby -v | awk '{print $2}' | cut -d'p' -f1)
  #     set right_prompt $right_prompt (set_color --bold red) '◃▸' (set_color --bold white) " ruby $rubyv " (set_color normal)
  #   end
  # end

  if git_is_repo
    set -l branch_name (git_branch_name)
    set -l git_porcelain (git_porcelain)
    if test ! -z "$git_porcelain"
      set git_distance "$git_porcelain "
    end

    set -l git_distance (git_distance)
    if test ! -z "$git_distance"
      set git_distance "($git_distance) "
    end

    set git_output "$git_distance$git_porcelain"\
    "[$branch_name] "
  end

  set right_prompt "$git_output"
  echo -n -s $right_prompt
end
