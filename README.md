# ubnt-auto-fan-speed
Automatic fan speed setting on UDM-PRO 1.8.5, 1.8.6, 1.9.0, 1.9.1, 1.9.2, 1.9.3 or 1.10.0 release firmware to make it silenced. (Also works on 1.11.-x beta)



## WARNING
USE THIS ON YOUR OWN RISK.
If you apply inappropriate settings with this script, you will possibly (soft- or hard-) brick your equipment.



## What it does
It stops the build in service that monitors the thermal values, fan speed and connection of a HDD/SSD. After that it sets the thermal/fan chip (adt7475) to automatic mode. Once that is done it changes the thermal and fan threshold values specified in the script. If you like, you can change the values to your own preferences.



## Installation
* Install [on_boot.d](https://github.com/boostchicken/udm-utilities)
* Copy [`on_boot.d/11-ubnt-auto-fan-speed.sh`](https://github.com/renedis/ubnt-auto-fan-speed/raw/main/on_boot.d/11-ubnt-auto-fan-speed.sh) to your UDM (Pro) in `/mnt/data/on_boot.d`
* `chmod +x /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`
* Adjust the settings if you want (or use mine)
* Run the script: `sh /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`

It will survive a reboot thanks to @boostchicken 's bootscript. The OLED screen does show correct percentage and RPM. But it does not respond to changes anymore (the "slide" trick).
