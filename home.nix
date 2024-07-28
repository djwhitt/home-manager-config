{ pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "libxls-1.6.2" ];
  };

  fonts.fontconfig.enable = true;

  programs.chromium.enable = true;
  programs.google-chrome.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    #extensions = with pkgs.vscode-extensions; [
    #  github.copilot
    #  vscodevim.vim
    #];
  };

  home.homeDirectory = "/home/djwhitt";
  home.username = "djwhitt";

  home.packages = with pkgs; [
    ## CLI

    (aspellWithDicts (d: [ d.en ]))
    (hunspellWithDicts (with hunspellDicts; [ en-us ]))
    (nnn.override { withNerdIcons = true; })
    atuin
    bat # cat clone with syntax highlighting and git integration
    bind
    bitwarden-cli
    btop
    difftastic
    direnv
    ditaa
    exiftool # cli app for reading, writing and editing meta information
    fd # alternative to find
    ffmpeg
    file
    #fzf          # cli fuzzy finder
    gcc
    gh
    git
    git-lfs
    gitAndTools.git-annex
    gnuplot
    graphviz
    hledger
    httperf
    inotify-tools
    jekyll
    jq
    jsonnet
    lazygit # terminal UI for git
    lf # terminal file manager
    llama-cpp
    mediainfo # unified display of technical and tag data for video and audio files
    mitmproxy
    mr
    nmap
    odt2txt # for opendocument previews
    offlineimap
    perkeep
    pistol # cli tool for previewing files
    plantuml
    poppler_utils # for pdf previews
    #python38Packages.html2text
    #python38Packages.pdftotext
    #python38Packages.pip
    restic # backup tool
    ripgrep
    sc-im
    sox
    tmuxp # tmux workspace manager
    visidata
    w3m
    zip

    ##
    ## Development
    ##

    # Linters, formatters, and LSP servers
    bash-language-server
    biome # TypeScript linter and formatter
    clj-kondo # Linter
    clojure-lsp
    efm-langserver # Generic LSP
    lua-language-server
    luajitPackages.luacheck # Linter
    nil # Nix LSP
    nixfmt-rfc-style
    python310Packages.flake8 # Linter
    python310Packages.isort # Formatter
    selene # Lua formatter
    shellcheck
    stylua
    terraform-ls # LSP
    yamllint
    yapf # Python formatter

    # Build tools
    leiningen

    # Languages and runtimes
    babashka
    clojure
    nodejs-18_x
    openjdk
    python3

    # Database
    duckdb
    postgresql_15
    sqlite-interactive

    # Ops
    aws-vault
    awscli
    docker-compose
    packer
    terraform
    terraform-docs
    terragrunt

    # Editors
    emacs
    neovim
    neovim-remote

    ##
    ## Desktop
    ##

    # X utils
    copyq # clipboard manager
    feh
    flameshot # screenshot tool
    glxinfo
    gnome.eog # image viewer
    libnotify
    rofi # switcher/launcher
    wmctrl
    xclip
    xdotool
    xorg.xev # X event viewer
    xorg.xprop
    xorg.xwininfo
    xsel

    # Communication
    discord
    neomutt
    notmuch # mail indexer
    signal-desktop
    slack
    tdesktop # telegram client

    # Fonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
      ];
    })
    carlito
    fira-code

    # Gnome utils
    gnome.dconf-editor

    # Graphics
    drawio
    gimp
    inkscape

    # Crypto
    ledger-live-desktop
    trezor-suite

    # Browsers
    brave
    firefox

    # Misc
    anki
    bitwarden
    evince
    ffmpegthumbnailer # video thumbnailer
    freeplane
    gnumeric
    leafpad
    libreoffice
    ncftp
    netlogo
    pamixer
    paperwork
    pulseaudio
    spotify
    standardnotes
    steam
    steam-run
    transmission-gtk
    vlc
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "DejaVu Sans 11";

        markup = "yes";
        plain_text = "no";

        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        # Markup is allowed
        format = ''
          <b>%s</b>
          %b'';

        # Sort messages by urgency.
        sort = "no";

        # Show how many messages are currently hidden (because of geometry).
        indicate_hidden = "yes";

        # Alignment of message text.
        # Possible values are "left", "center" and "right".
        alignment = "center";

        # The frequency with wich text that is longer than the notification
        # window allows bounces back and forth.
        # This option conflicts with "word_wrap".
        # Set to 0 to disable.
        bounce_freq = 0;

        # Show age of message if message is older than show_age_threshold
        # seconds.
        # Set to -1 to disable.
        show_age_threshold = -1;

        # Split notifications into multiple lines if they don't fit into
        # geometry.
        word_wrap = "yes";

        # Ignore newlines '\n' in notifications.
        ignore_newline = "no";

        # Hide duplicate's count and stack them
        stack_duplicates = "yes";
        hide_duplicate_count = "yes";

        # The geometry of the window:
        #   [{width}]x{height}[+/-{x}+/-{y}]
        # The geometry of the message window.
        # The height is measured in number of notifications everything else
        # in pixels.  If the width is omitted but the height is given
        # ("-geometry x2"), the message window expands over the whole screen
        # (dmenu-like).  If width is 0, the window expands to the longest
        # message displayed.  A positive x is measured from the left, a
        # negative from the right side of the screen.  Y is measured from
        # the top and down respectevly.
        # The width can be negative.  In this case the actual width is the
        # screen width minus the width defined in within the geometry option.
        #geometry = "250x50-40+40"
        geometry = "800x200-20+60";

        # Shrink window if it's smaller than the width.  Will be ignored if
        # width is 0.
        shrink = "no";

        # The transparency of the window.  Range: [0; 100].
        # This option will only work if a compositing windowmanager is
        # present (e.g. xcompmgr, compiz, etc.).
        #transparency = 5;

        # Don't remove messages, if the user is idle (no mouse or keyboard input)
        # for longer than idle_threshold seconds.
        # Set to 0 to disable.
        idle_threshold = 0;

        # Which monitor should the notifications be displayed on.
        monitor = 0;

        # Display notification on focused monitor.  Possible modes are:
        #   mouse: follow mouse pointer
        #   keyboard: follow window with keyboard focus
        #   none: don't follow anything
        #
        # "keyboard" needs a windowmanager that exports the
        # _NET_ACTIVE_WINDOW property.
        # This should be the case for almost all modern windowmanagers.
        #
        # If this option is set to mouse or keyboard, the monitor option
        # will be ignored.
        follow = "none";

        # Should a notification popped up from history be sticky or timeout
        # as if it would normally do.
        sticky_history = "yes";

        # Maximum amount of notifications kept in history
        history_length = 15;

        # Display indicators for URLs (U) and actions (A).
        show_indicators = "no";

        # The height of a single line.  If the height is smaller than the
        # font height, it will get raised to the font height.
        # This adds empty space above and under the text.
        line_height = 3;

        # Draw a line of "separatpr_height" pixel height between two
        # notifications.
        # Set to 0 to disable.
        separator_height = 2;

        # Padding between text and separator.
        padding = 6;

        # Horizontal padding.
        horizontal_padding = 6;

        # Define a color for the separator.
        # possible values are:
        #  * auto: dunst tries to find a color fitting to the background;
        #  * foreground: use the same color as the foreground;
        #  * frame: use the same color as the frame;
        #  * anything else will be interpreted as a X color.
        separator_color = "frame";

        # Print a notification on startup.
        # This is mainly for error detection, since dbus (re-)starts dunst
        # automatically after a crash.
        startup_notification = false;

        # dmenu path.
        dmenu = "/run/current-system/sw/bin/dmenu -p dunst:";

        # Browser for opening urls in context menu.
        browser = "/home/djwhitt/.nix-profile/bin/brave";

        frame_width = 3;
        frame_color = "#8EC07C";
      };

      urgency_low = {
        frame_color = "#3B7C87";
        foreground = "#3B7C87";
        background = "#191311";
        timeout = 4;
      };

      urgency_normal = {
        frame_color = "#5B8234";
        foreground = "#5B8234";
        background = "#191311";
        timeout = 6;
      };

      urgency_critical = {
        frame_color = "#B7472A";
        foreground = "#B7472A";
        background = "#191311";
        timeout = 8;
      };
    };
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #

  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}
