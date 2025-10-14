#####################
# Fish home module. #
#####################
{...}: {
  programs.fish = {
    enable = true;

    # Fish functions.
    functions = {
      fish_greeting = ''
        echo "Welcome, $(set_color green; echo -n $USER; set_color normal)! This is fish shell."
        echo ""
      '';
    };
  };
}
