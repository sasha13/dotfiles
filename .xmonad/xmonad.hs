

-- Import statements
import XMonad
import Control.Monad
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M
-- *Layoum t
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
-- *Util
import XMonad.Util.Run
import XMonad.Util.EZConfig
import qualified XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt
-- *Actions
-- *Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks


-- Define Terminal
myTerminal = "urxvt"


-- Define Workspaces
myWorkspaces = ["chat", "web", "dev", "db", "media"]


-- Bind apps to workspaces
myManageHook = composeAll . concat $
  [
    -- Apps bound to 'web'
    [ className =? b --> viewShift "web" | b <- myClassWebShifts ],
    -- Apps bound to 'chat'
    [ className =? c --> doF (W.shift "chat") | c <- myClassChatShifts ],
    -- Apps bound to 'media'
    [ className =? m --> viewShift "media" | m <- myClassMediaShifts ],
    -- Floating apps 
    [ className =? f --> doFloat | f <- myClassFloats ]
  ]
  where
    viewShift = doF . liftM2 (.) W.greedyView W.shift
    myClassWebShifts = ["Firefox", "Google-chrome"]
    myClassChatShifts = ["Empathy"]
    myClassMediaShifts = ["Vlc"]
    myClassFloats = ["Vlc"]


-- Define default layouts
defaultLayouts = avoidStruts $ (tiled ||| Mirror tiled ||| simpleFloat ||| Full)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio
    -- default number of windows in the master pane
    nmaster = 1
    -- default proportion of screen occupied by master pane
    ratio = 3/5
    -- percent of screen to increment when resizing panes
    delta = 3/100


-- Define layouts for specific workspaces
webLayout = avoidStruts $ noBorders $ Full


-- Put all layouts together
myLayouts = onWorkspace "web" webLayout $ defaultLayouts


-- Getting rid of borders
myBorderWidth :: Dimension 
myBorderWidth = 0


-- logHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP {ppOutput = hPutStrLn h }


-- Bar appearance
customPP :: PP
customPP = defaultPP {
                      ppHidden = xmobarColor "#CC9900" "",
                      ppCurrent = xmobarColor "#669900" "" . wrap "[" "]",
                      ppUrgent = xmobarColor "#E84F4F" "" . wrap "*" "*",
                      ppLayout = \x -> "",
                      ppTitle = xmobarColor "#B8D68C" "" . shorten 60,
                      ppSep = "<fc=#A0CF5D> :: </fc>"
                     }

-- Colours for prompt windows
myXPConfig = defaultXPConfig
  {
  font = "xft:Liberation Mono:size=10:antialias=true:hinting=true",
  bgColor = "#151515",
  fgColor = "#D7D0C7",
  fgHLight = "#D7D0C7",
  bgHLight = "#151515",
  borderColor = "#151515",
  promptBorderWidth = 1,
  position = Bottom,
  height = 14,
  historySize = 50
  }

-- StartupHook
myStartupHook :: X ()
myStartupHook = do
  spawn "xset r rate 180 90"
  spawn "xrdb -load ~/.Xresources"


-- Keys
myModMask :: KeyMask
myModMask = mod4Mask

-- otkomenatrisi kad skontas ovu uniju sa postojecim keybindings
-- isto i u pozivu main =do dole 'keys'
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList
  [
    -- close window
    ((modMask, xK_c), kill),
    -- open terminal
    ((modMask, xK_F1), spawn $ XMonad.terminal conf),
    -- program launcher
    ((modMask, xK_F2), shellPrompt myXPConfig)
  ]

newKeys x = M.union (myKeys x) (keys defaultConfig x)


-- Run XMonad
main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig {
    terminal = myTerminal,
    workspaces = myWorkspaces,
    manageHook = myManageHook,
    layoutHook = myLayouts,
    logHook = myLogHook xmproc,
    borderWidth = myBorderWidth,
    startupHook = myStartupHook,
    modMask = myModMask,
    keys = newKeys
  }
