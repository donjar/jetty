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

  if type -q git
    set normal (set_color normal)
    set dirty (set_color black -b F38630)
    set clean (set_color black -b 7AB317)
    set detached (set_color black -b FF0000)
    if set branch_name (git_branch_name)
      set -l gitporcelain (git_porcelain)
      set -l git_distance (git_distance)
      if test ! -z "$git_distance"
        set git_distance "($git_distance)"
      end
      set -l repo_status
      set -l branch_color ""

      if git_is_dirty
        set branch_color "$dirty"
      else
        set branch_color "$clean"
      end

      if git_is_staged
        if git_is_dirty
          set git_status "± "
        else
          set git_status "+ "
        end
      end

      if git_is_empty
        set repo_status "●"
      end

      if git_is_stashed
        set repo_status ".."
      end

      set git_output "$branch_color $branch_name$repo_status$git_distance $normal $gitporcelain"
    end
  end

  set right_prompt "$git_output"
  echo -n -s $right_prompt
end
