-------------------------------------------------------------------------
-- IMPORTS
-------------------------------------------------------------------------

-- Base
import XMonad
import System.Exit
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextWS, prevWS, nextScreen, prevScreen)
import XMonad.Actions.SpawnOn
import XMonad.Actions.OnScreen (viewOnScreen)

-- Data
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Ratio
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.WindowSwallowing

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig (mkKeymap)

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Reflect

import XMonad.Layout.Fullscreen
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit , decreaseLimit)
--import XMonad.Layout.MultiToggle
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Renamed
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts

-- Graphics
import Graphics.X11.ExtraTypes.XF86

-- Color Schemes
import Colors.TokyoNight
           -- SolarizedDark
           -- SolarizedLight
           -- Nord
           -- Monokai
           -- TokyoNight
           -- OceanicNext
------------------------------------------------------------------------
--TERMINAl
------------------------------------------------------------------------
myTerminal      = "alacritty"

------------------------------------------------------------------------
--FOCUS
------------------------------------------------------------------------
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

------------------------------------------------------------------------
-- BORDER
------------------------------------------------------------------------
-- Border Width
myBorderWidth        = 2

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = colorBk
myFocusedBorderColor = color01

------------------------------------------------------------------------
-- MODKEY
------------------------------------------------------------------------
myModMask = mod4Mask 
------------------------------------------------------------------------
-- Other Stuff
------------------------------------------------------------------------
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


------------------------------------------------------------------------
-- Workspaces
------------------------------------------------------------------------
myWorkspaces :: [String]
myWorkspaces = ["dev", "www", "doc", "edi", "chat", "vid", "log"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

------------------------------------------------------------------------
-- Boxes (W.RationalRect -horizontalMOVE -verticalMOVE -widthSIZE -heightSIZE)
------------------------------------------------------------------------
doKeybindBox = doRectFloat (W.RationalRect 0.4 0.17 0.2 0.71)
doPassBox = doRectFloat (W.RationalRect 0.44 0.45 0.12 0.03)
doWeatherBox = doRectFloat (W.RationalRect 0.26 0.2 0.5 0.58)
doPrayerBox = doRectFloat (W.RationalRect 0.42 0.4 0.16 0.14)
doMessageBox = doRectFloat (W.RationalRect 0.26 0.2 0.5 0.58)

------------------------------------------------------------------------
-- Add Spacing
------------------------------------------------------------------------
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

------------------------------------------------------------------------
-- Layouts
------------------------------------------------------------------------
tall     = renamed [Replace "tall"]
           $ limitWindows 5
           $ smartBorders
           -- $ windowNavigation
           -- $ addTabs shrinkText
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []

floats   = renamed [Replace "floats"]
           -- $ smartBorders
           -- $ simplestFloat

grid     = renamed [Replace "grid"]
           $ limitWindows 9
           $ smartBorders
           -- $ windowNavigation
           -- $ addTabs shrinkText
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ Grid (16/10)

spirals  = renamed [Replace "spirals"]
           $ limitWindows 9
           $ smartBorders
           -- $ windowNavigation
           -- $ addTabs shrinkText
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ spiral (6/7)

------------------------------------------------------------------------
-- KEYBINDINGS
------------------------------------------------------------------------
myKeys conf = mkKeymap conf $  
 
    -- KB_group XMoanad
    [ ("M-q"               , spawn "xmonad --recompile && xmonad --restart") -- recompile and restart.
    , ("M-S-q"             , io (exitWith ExitSuccess)) -- quit xmonad.
    , ("M-p k"             , spawnAndDo doKeybindBox "alacritty --hold -e .config/xmonad/lib/xmonad-keybinds.sh") -- keybinds (this list)

    -- KB_group launch Apps
    , ("M-r"               , spawn "dmenu_run")          -- launch Dmenu 
    , ("M-<Return>"        , spawn "alacritty")          -- launch Alacritty
    , ("M-l f"             , spawn "pcmanfm")            -- launch Pcmanfm
    , ("M-l b"             , spawn "brave")              -- launch Brave
    , ("M-l l"             , spawn "libreoffice")        -- launch Libreoffice
    , ("M-l d"             , spawn "discord")            -- launch Discord
    , ("M-l m"             , sequence_ [spawnOn "chat" "alacritty -e neomutt", windows $ W.greedyView "chat"]) -- launch Neomutt

    -- KB_group Actions    
    , ("M-<Tab>"           , sendMessage NextLayout)             -- cycle through Layouts
    , ("M-S-<Tab>"         , setLayout $ XMonad.layoutHook conf) -- reset Layout
    , ("M-S-0"             , withFocused $ windows . W.sink)     -- back from Float to Layouts

    , ("M-S-r"             , refresh)                    -- correct window-size
    , ("M-j"               , windows W.focusDown)        -- focus on next window
    , ("M-k"               , windows W.focusUp)          -- focus on previous window
    , ("M-S-m"             , windows W.focusMaster)      -- focus on master window
    , ("M-S-c"             , kill)                       -- kill Window
    , ("M-S-f"             , sendMessage (Toggle "Full")) -- fullscreen Window
    , ("M-S-j"             , windows W.swapDown)         -- Swap to next window
    , ("M-S-k"             , windows W.swapUp)           -- Swap to previous window
    , ("M-S-<End>"         , spawn "xset dpms force off")-- Shuts down screen
    
    -- KB_group Scripts
    , ("M1-<Shift_L>"      , spawn "~/.local/bin/toggle-keylay")  -- swap Keyboard layout
    , ("<Print>"           , spawn "~/.local/bin/screen-clip")    -- screenshot + save to clip
     
    -- KB_group Dmenu Scripts
    , ("M-p e"             , spawn "~/.config/dmscripts/dm-editconf")    -- dmenu config files
    , ("M-p s"             , spawn "~/.config/dmscripts/dm-websearch")   -- dmenu web search
    , ("M-p r"             , spawn "~/.config/dmscripts/dm-radio")       -- dmenu online Radio
    , ("M-p g"             , spawn "~/.config/dmscripts/dm-podcast")     -- dmenu online Podcast
    , ("M-p b"             , spawn "~/.config/dmscripts/dm-bookmarks")   -- dmenu Bookmarks
    , ("M-p n"             , spawn "~/.config/dmscripts/dm-notes")       -- dmenu Notes
    , ("M-p u"             , spawn "~/.config/dmscripts/dm-usbmount")    -- dmenu USB mount/unmount
    , ("M-p c"             , spawn "~/.config/dmscripts/dm-colorscheme") -- dmenu Colorscheme
    , ("M-p f"             , spawn "~/.config/dmscripts/dm-font")        -- dmenu Font
    , ("M-p a"             , spawn "~/.config/dmscripts/dm-sound")       -- dmenu Select Sound
    , ("M-p y"             , spawnAndDo doPassBox "~/.config/dmscripts/dm-bluetooth")  -- dmenu Bluetooth
    , ("M-p p"             , spawnAndDo doPassBox "~/.config/dmscripts/dm-power")      -- dmenu Power
    , ("M-p w"             , spawnAndDo doWeatherBox "~/.config/dmscripts/dm-weather") -- dmenu Check weather
    , ("M-p j"             , spawn "passmenu -i -l 20 -p 'Password:'")   -- dmenu Password Manager
    , ("M-p v"             , spawnAndDo doPrayerBox "~/.config/dmscripts/dm-prayer")  -- dmenu Check Prayer Time


    -- Switchers 

    -- Parameters
    
    , ("<XF86AudioRaiseVolume>" , spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%") -- volume up
    , ("<XF86AudioLowerVolume>" , spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%") -- volume down
    
    -- switch WS with 
    , ("M-<R>"             , nextWS) -- M + -> to next Workspace
    , ("M-<L>"             , prevWS) -- M + <- to previous Workspace
 
    -- Resize windows
    , ("M-C-l", sendMessage Expand)
    , ("M-C-h", sendMessage Shrink)
    , ("M-C-j", sendMessage MirrorExpand)
    , ("M-C-k", sendMessage MirrorShrink)
   

    -- Switch To Workspace N [1..7]
    -- Shift Window to Workspaces N [1..7]
    ] ++
    [(m ++ k, windows $ f w)
        | (w, k) <- zip (XMonad.workspaces conf) (map show [1..7])
        , (m, f) <- [("M-",W.greedyView), ("M-S-",W.shift)]]


------------------------------------------------------------------------
-- Layouthook:
------------------------------------------------------------------------
myLayout = avoidStruts $ withBorder myBorderWidth $ toggleLayouts Full (
                                                    tall
                                                ||| reflectHoriz tall
                                                --  ||| Mirror tall
                                                ||| grid
                                                ||| spirals
                                                ||| Accordion )

------------------------------------------------------------------------
-- Manage Hook:
-- Hint: To find the property name associated with a program, use xprop!
------------------------------------------------------------------------
myManageHook = composeAll 
    [ className =? "Gimp"               --> doFloat
    , className =? "Xmessage"           --> doMessageBox 
    , className =? "mpv"                --> doFloat 
    , className =? "Brave-browser"      --> doShift ( myWorkspaces !! 1 )
    , className =? "Pcmanfm"            --> doShift ( myWorkspaces !! 2 )
    , className =? "libreoffice-startcenter"  
                                        --> doShift ( myWorkspaces !! 3 )
    , className =? "discord"            --> doShift ( myWorkspaces !! 4 )
    , className =? "mpv"                --> doShift ( myWorkspaces !! 5 )
    , isDialog                                --> doCenterFloat 
    ]

------------------------------------------------------------------------
-- Event handling
------------------------------------------------------------------------
myEventHook = swallowEventHook (className =? "Alacritty") (return True)

------------------------------------------------------------------------
-- Status bars and logging
------------------------------------------------------------------------
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
-- myLogHook = return ()


------------------------------------------------------------------------
-- Autostart apps
------------------------------------------------------------------------
myStartupHook = do 
  windows $ viewOnScreen 0 "chat"  -- show workspace 5 on screen   
  windows $ viewOnScreen 1 "dev"
  spawnOnce "$HOME/.local/bin/reso"
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom --config .config/picom/picom.conf &"
  spawnOnce "xsetroot -cursor_name left_ptr &"
  spawnOnce "xsettingsd &"
  spawnOnce "pcloud &"
  spawnOnce "synclient TapButton1=1" -- for touchpad click

------------------------------------------------------------------------
-- Main Hook
------------------------------------------------------------------------
main = do
  xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/" ++ colorScheme ++ "-xmobar.hs " ++ "-B" ++ colorBk ++ " -F" ++ colorFr)
  xmonad $ ewmh $ docks $ def
      {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = manageSpawn <+> myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook,
        logHook            = dynamicLogWithPP xmobarPP
          { ppOutput  = \x -> hPutStrLn xmproc0 x
                          -- >> hPutStrLn xmproc1 x
          -- current workspace
          , ppCurrent = xmobarColor color02 "" . wrap ("<box type=Top width=2 mb=2 color=" ++ color02 ++ ">") "</box>" 
          -- workspaces in use
          , ppHidden  = xmobarColor color02 "" . clickable
          -- workspaces not in use
          , ppHiddenNoWindows = xmobarColor color03 "" . clickable
          -- Layout
          , ppLayout  = xmobarColor color04 ""
          -- window counter
          , ppExtras  = [ (fmap . fmap) num $ windowCount ]
          -- separator/s
          , ppSep     = " | "
          , ppWsSep   = "  "
          -- window title 
          , ppTitle   = xmobarColor color06 "" . shorten 20
          
          -- Other
          , ppOrder   = \(ws:l:t:ex) -> [ws, l]++ex++[t]  
          , ppUrgent  = xmobarColor color01 "" . shorten 60
          , ppVisible = xmobarColor color01 "" . clickable
          }
      }
      where
        num :: String -> String
        num = xmobarColor color05 colorBk
