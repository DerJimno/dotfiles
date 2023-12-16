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

import XMonad.Layout.Fullscreen
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit , decreaseLimit)
import XMonad.Layout.MultiToggle
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Renamed
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts

-- Graphics
import Graphics.X11.ExtraTypes.XF86

-- Color Schemes
import Colors.SolarizedDark
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
myFocusedBorderColor = color06

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
myWorkspaces = ["dev", "www", "doc", "chat", "vid", "mus", "gfx", "not", "gam"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

dialogBox = doRectFloat (W.RationalRect 0.05 0.05 0.9 0.9) 
downloadBox = doRectFloat (W.RationalRect 0.24 0.3 0.5 0.5) 
passBox = doRectFloat (W.RationalRect 0.35 0.35 0.25 0.25) 


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
monocle  = renamed [Replace "monocle"]
           -- $ smartBorders
           -- $ windowNavigation
           -- $ addTabs shrinkText
           $ subLayout [] (smartBorders Simplest)
           -- $ Full
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
 
    -- XMoanad
    [ ("M-q"               , spawn "xmonad --recompile; xmonad --restart") -- recompile and restart.
    , ("M-S-q"             , io (exitWith ExitSuccess)) -- Quit xmonad.

    -- launch Apps
    , ("M-r"               , spawn "dmenu_run")          -- launch Dmenu 
    , ("M-<Return>"        , spawn "alacritty")          -- launch Alacritty
    , ("M-f"               , spawn "pcmanfm")            -- launch Pcmanfm
    , ("M-b"               , spawn "brave")              -- launch Brave
    , ("M-S-l"             , spawn "libreoffice")        -- Launch Libreoffice
    , ("M-S-m"             , spawnOn "chat" "alacritty -e .local/bin/chmutt 10") -- Launch Neomutt

    -- Actions    
    , ("M-<Tab>"           , sendMessage NextLayout)             -- cycle through Layouts
    , ("M-S-<Tab>"         , setLayout $ XMonad.layoutHook conf) -- reset Layout

    , ("M-S-r"             , refresh)                    -- Correct window-size
    , ("M-j"               , windows W.focusDown)        -- focus on next window
    , ("M-k"               , windows W.focusUp)          -- focus on previous window
    , ("M-m"               , windows W.focusMaster)      -- focus on master window
    , ("M-S-c"             , kill)                       -- kill Window
    , ("M-S-f"             , toggleFull)                 -- fullscreen Window
    , ("M-S-j"             , windows W.swapDown)         -- Swap to next window
    , ("M-S-k"             , windows W.swapUp)           -- Swap to previous window
    , ("M-S-<End>"         , spawn "xset dpms force off")-- Shuts down screen
    
    -- Scripts
    , ("M1-<Shift_L>"      , spawn "~/.local/bin/toggle-keylay")  -- swap Keyboard layout
    , ("<Print>"           , spawn "~/.local/bin/screen-clip")    -- take Screenshot + save to Clip
     
    -- Dmenu Scripts
    , ("M-p e"             , spawn "~/.config/dmscripts/dm-editconf")    -- Dmenu config files
    , ("M-p s"             , spawn "~/.config/dmscripts/dm-websearch")   -- Dmenu web search 
    , ("M-p r"             , spawn "~/.config/dmscripts/dm-radio")       -- Dmenu online Radio
    , ("M-p g"             , spawn "~/.config/dmscripts/dm-podcast")     -- Dmenu online Podcast
    , ("M-p b"             , spawn "~/.config/dmscripts/dm-bookmarks")   -- Dmenu Bookmarks
    , ("M-p n"             , spawn "~/.config/dmscripts/dm-notes")       -- Dmenu Notes
    , ("M-p u"             , spawn "~/.config/dmscripts/dm-usbmount")    -- Dmenu USB mount/unmount
    , ("M-p c"             , spawn "~/.config/dmscripts/dm-colorscheme") -- Dmenu Colorscheme 
    , ("M-p f"             , spawn "~/.config/dmscripts/dm-font")        -- Dmenu Font 
    , ("M-p p"             , spawnAndDo passBox "~/.config/dmscripts/dm-power")     -- Dmenu Power 
    , ("M-p w"             , spawnAndDo dialogBox "~/.config/dmscripts/dm-weather") -- Dmenu Check weather
    , ("M-p j"             , spawn "passmenu -i -l 20 -p 'Password:'") -- Dmenu USB mount/unmount

    -- Parameters
    , ("<XF86MonBrightnessUp>"  , spawn "brillo -q -A 5") -- increase Brightness
    , ("<XF86MonBrightnessDown>", spawn "brillo -q -U 5") -- decrease Brightness
    
    , ("<XF86AudioRaiseVolume>" , spawn "amixer -c 1 sset Master 5%+") -- Volume up
    , ("<XF86AudioLowerVolume>" , spawn "amixer -c 1 sset Master 5%-") -- Volume down
    
    -- switch WS with 
    , ("M-<R>"             , nextWS) -- M + -> to next Workspace
    , ("M-<L>"             , prevWS) -- M + <- to previous Workspace
    -- 
    ] ++

    -- m-[1..9], Switch to workspace N
    [(m ++ k, windows $ f w)
        | (w, k) <- zip (XMonad.workspaces conf) (map show [1..9])
        , (m, f) <- [("M-",W.greedyView), ("M-S-",W.shift)]]

------------------------------------------------------------------------
-- Layouthook:
------------------------------------------------------------------------
myLayout = avoidStruts $ withBorder myBorderWidth $ tall 
                                                ||| Mirror tall
                                                ||| grid
                                                ||| Accordion
                                                ||| spirals                                


------------------------------------------------------------------------
-- Manage Hook:
-- Hint: To find the property name associated with a program, use xprop!
------------------------------------------------------------------------
myManageHook = composeAll 
    [ className =? "MPlayer"            --> doFloat
    , className =? "Gimp"               --> doFloat
    , className =? "error"              --> doFloat
    , className =? "libreoffice"        --> doFloat
    , className =? "mpv"                --> doFloat 
    , className =? "Alacritty"          --> doShift ( myWorkspaces !! 0 )
    , className =? "Brave-browser"      --> doShift ( myWorkspaces !! 1 )
    , className =? "Pcmanfm"            --> doShift ( myWorkspaces !! 2 )
    , className =? "mpv"                --> doShift ( myWorkspaces !! 4 )
    , title     =? "Save File"          --> downloadBox
    --, resource  =? "desktop_window"     --> doIgnore
    --, resource  =? "kdesktop"         --> doIgnore 
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
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
  spawnOnce "volumeicon &"
  spawnOnce "xsetroot -cursor_name left_ptr &"
  spawnOnce "setxkbmap -option caps:none &"
  spawnOnce "xsettingsd &"
  spawnOnce "pcloud &"

-----------------------------------------------------------------------
-- fullscreen window
-----------------------------------------------------------------------
toggleFull = withFocused (\windowId -> do
    { floats <- gets (W.floating . windowset);
        if windowId `M.member` floats
        then withFocused $ windows . W.sink
        else withFocused $ windows . (flip W.float $ W.RationalRect 0 0 1 1) })  

------------------------------------------------------------------------
-- Main Hook
------------------------------------------------------------------------
main = do
  xmproc0 <- spawnPipe ("xmobar -x 0 ~/.config/xmobar/" ++ colorScheme ++ "-xmobar.hs " ++ "-B" ++ colorBk ++ " -F" ++ colorFr)
  -- xmproc1 <- spawnPipe ("xmobar -x 1 ~/.config/xmobar/" ++ colorScheme ++ "-xmobar.hs " ++ "-B" ++ colorBk ++ " -F" ++ colorFr)
  xmonad $ewmh $ docks $ def
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
          , ppCurrent = xmobarColor color06 "" . wrap ("<box type=Top width=2 mb=2 color=" ++ color06 ++ ">") "</box>" 
          , ppVisible = xmobarColor color04 "" . clickable
          , ppHidden  = xmobarColor color06 "" . clickable
          , ppHiddenNoWindows = xmobarColor color05 "" . clickable
          , ppTitle   = xmobarColor color11 "" . shorten 20
          , ppSep     = "<fc=" ++ color11 ++ "> | </fc>"
          , ppWsSep   = "  "
          , ppUrgent  = xmobarColor color02 "" . shorten 60
          , ppExtras  = [ (fmap . fmap) num $ windowCount ]
          , ppLayout  = xmobarColor color07 ""                   
          , ppOrder   = \(ws:l:t:ex) -> [ws, l]++ex++[t]  

          }
      }
      where
        num :: String -> String
        num = xmobarColor color03 colorBk
