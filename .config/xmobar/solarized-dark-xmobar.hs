Config { 
   -- appearance
     font = "Ubuntu Mono Bold 11"
   , additionalFonts = [ "Monoki Nerd Font 15"
                       , "Monoki Nerd Font 25"
                       , "Monoki Nerd Font 16"
                       ]
   , bgColor =      "#002b36"
   , fgColor =      "#839496"
   , position =     TopH 20
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)

   , commands = 
        [
        -- network activity monitor (dynamic interface resolution)
          Run Network "enp34s0" ["-t", "<fn=1>\xf0aa</fn> <tx>kb <fn=1>\xf0ab</fn> <rx>kb"] 20
        -- cpu activity monitor
        , Run Cpu [ "-t", "<fn=1>\xf4bc</fn> <total>%", "-H", "50", "--high", "red"] 20
        -- get workspaces
        , Run UnsafeStdinReader
        -- cpu core temperature 
	    -- disk space available
	    , Run DiskU [("/", "<fn=1>\xf0a0</fn> <free>")] [] 60

        -- Volume
        , Run Com "echo" ["<fn=1>\xe638</fn>"] "volicon" 3600
        , Run Com ".local/bin/vol" [] "vol" 1
        -- memory usage monitor
        , Run Memory ["-t", "<fn=1>\xe266</fn> <used>M (<usedratio>%)"] 20
        -- time and date
        , Run Date "<fn=1>\xf18fa</fn> %d %b %y - (%H:%M)" "date" 50

        -- pacupdate
        , Run Com "echo" ["<fn=1>\xf0b7e</fn> "] "pacupicon" 3600
        , Run Com ".local/bin/pacup" [] "pacup" 3600
        , Run Com "echo" ["<fn=1>\xf2c9</fn> "] "cpu-temp-icon" 3600
        , Run Com ".local/bin/cpu-temp" [] "cpu-temp" 20 
        -- keyboard layout indicator
        , Run Com "echo" ["<fn=1>\xf030c</fn> "] "kbdicon" 3600
        , Run Com "echo" ["<fn=2>\xe739</fn>"] "logo" 36000 
        , Run Kbd            [ ("us"  ,"<fn=3>\xf0af2</fn>")
                             , ("ara" ,"<fn=3>\xf0aee</fn>")
                             ]
        ]
        -- layout
        , sepChar =  "%"
        , alignSep = "}{"
        , template = " <fc=#d33682>%logo%</fc> | %UnsafeStdinReader% }{ <fc=#859900>%pacupicon%%pacup%</fc> | <fc=#2aa198>%cpu%</fc> | <fc=#2aa198>%cpu-temp-icon%%cpu-temp%</fc> | <fc=#268bd2>%disku%</fc> | <fc=#6c71c4>%memory%</fc> | <fc=#6c71c4>%enp34s0%</fc> | <fc=#cb4b16>%date%</fc> | <fc=#d33682>%volicon% %vol%</fc> | <fc=#d33682>%kbdicon%%kbd%</fc> "

