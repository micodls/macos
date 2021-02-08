# MacOS Catalina (10.15.7) Setup

## Finder
---
### Set Finder defaults
1. Run on Terminal to clear
```
$ sudo find / -name .DS_Store -delete; killall Finder
```
2. Finder -> View -> Show View Options
3. Fix `Sort By` option.
4. Click `Use as Defaults` at the bottom

## System Preferences
---
### Dock
1. Adjust `Size`
2. Set `Position on screen: left`
3. Untick `Show recent applications in Dock`

### General
1. Set `Default web browser: Google Chrome Canary`

## App Store
1. Download the following:
   - iMovie

## Others
1. Download the following:
   - [Paragon Driver](https://www.seagate.com/as/en/support/software/paragon/)
   - [Seagate Toolkit](https://www.seagate.com/as/en/support/software/toolkit/)
   - [Logitech GHub](https://www.logitechg.com/en-us/innovation/g-hub.html)
2. Checkout the following:
   - [Aureal](https://github.com/notjosh/Aureal) -- requires xcode; does not work

## PayMaya
1. Upload [keyring.all](keyring.all) in Mailvelope
2. Install either Anyconnect via installer or Openconnect via brew