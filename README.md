# My notes

## matplotlib

When qt fails, use

```python
matplotlib.use('Agg')
```

This doesn't support interactive but can save figures



set default configs (for all options see [here](https://matplotlib.org/stable/users/explain/customizing.html#the-default-matplotlibrc-file))

```python
matplotlib.rc('axes', titlesize=22, labelsize=18)
matplotlib.rc('figure', figsize=(10, 6), dpi=300)
```

## Mac set iTerm2 override system light mode

https://stackoverflow.com/questions/78526264/how-to-set-iterm2-color-to-darkmode-with-powerlevel10k

## Clash Core

Download clash core, run `./clash --help` to see the flags. `-d` is for config directory, and `-f` is for config file.

If already used CFW, the config directory is `~/.config/clash` and the profile is `~/.config/clash/profiles/<timestamp>.yml`.

On MacOS, CFW has a memory leak so switching to core + web dashboard could help. Use `launchd` to setup an automatic task.

## Mac launchd service

Under folder `~/Library/LaunchAgents/`. Sample clash core plist by GPT:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.user.clash</string>
    <key>ProgramArguments</key>
    <array>
	<string>/Users/ldq/clashcore/clash</string>
      <string>-d</string>
	  <string>/Users/ldq/.config/clash</string>
      <string>-f</string>
	  <string>/Users/ldq/.config/clash/profiles/1725974166005.yml</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/clash.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/clash-error.log</string>
  </dict>
</plist>
```

Use `killall` seems to give a return code of 0 and it will not automatically restart.

[clash web dashboard](https://clash.razord.top)
