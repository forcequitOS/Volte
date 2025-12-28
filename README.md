# Volte
Jailbroken tvOS app with power options. Heavily inspired by [Dave1482's PowerApp.](https://github.com/Dave1482/PowerApp)

As always, tested on:
- tvOS 26.2 (23K54) on Apple TV 4K (1st generation)

Volte *should* be compatible with down to tvOS 14, but I have no means of testing this. Your mileage may vary.

This is a pretty simple app. Has a few massive buttons and a single option.

**Power Off:** Turns off the Apple TV. This is a pretty redundant and pointless option, since it turns right back on immediately anyways. Didn't know that going into this though, oh well...

**Restart:** Fully reboots the Apple TV. You'll lose your jailbreak. Good for troubleshooting and to get into DFU mode on the TV 4K.

**Respring:** Reloads PineBoard, the equivalent of iOS' SpringBoard for tvOS. Quits all apps, also good for troubleshooting.

**Restart Userspace:** Performs a userspace reboot, everything on the system will restart, EXCEPT for the kernel and any hardware, allowing you to keep your jailbreak while still rebooting.

**Refresh Icon Cache:** Runs the `uicache` command and resprings, good for if you installed or removed an app (Especially a jailbreak one) and it's not showing up, or is still showing up after removal.

**Exit Volte:** Quits the app and goes to the Home Screen. That's it.

By default, Volte asks for confirmation before doing any actions, these alerts can be disabled in the Settings tab with the "Show Confirmation Alerts" option. That's the single setting.

### Install:

Get it on **etaTV**: https://etatv.forcequit.cc

### Credits:

[PowerApp by Dave1482, while I used no code, it entirely is the inspiration for this](https://github.com/Dave1482/PowerApp)

Some posts on StackOverflow, helped me with the buttonless alert to use as a loading indicator for the UICache option

Claude & ChatGPT, figured out some stuff like getting posix_spawn to work (In the sketchiest way)

###### I'm currently aware that the buttons look way less saturated without Liquid Glass than with. I really don't know why. I blame Apple.
