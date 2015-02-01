import XMonad
 
main = xmonad defaultConfig
        { borderWidth		= 2
        , terminal		= "gnome-terminal"
	, focusedBorderColor	= "#3388ee"
	, normalBorderColor	= "#cccccc"
	, focusFollowsMouse	= True
        -- more changes
        }

