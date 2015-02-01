import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
	xmproc <- spawnPipe "/usr/bin/xmobar /home/pol/.xmobarrc"
	xmonad $ defaultConfig
        	{ manageHook = manageDocks <+> manageHook defaultConfig
        	, layoutHook = avoidStruts  $  layoutHook defaultConfig
		, borderWidth		= 2
        	, terminal		= "gnome-terminal"
		, focusedBorderColor	= "#3388ee"
		, normalBorderColor	= "#cccccc"
		, focusFollowsMouse	= True
		}

