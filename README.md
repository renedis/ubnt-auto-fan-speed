# ubnt-auto-fan-speed
Automatic fan speed setting on UDM-PRO (including SE) 1.12.38 release firmware to make it silenced. Also working on 2.x.x, 3.x.x, 4.x.x and 5.x.x!
On firmware 4.x.x and 5.x.x (not early access) Ubiquiti has changed the fan1/fan2/fan3/fan4 order.

`PWM1/TEMP3/FAN1 = Disk fan`

`PWM2/TEMP1/FAN2 = CPU fan`


## WARNING
USE THIS ON YOUR OWN RISK.
If you apply inappropriate settings with this script, you will possibly (soft- or hard-) brick your equipment.

# Scripted Installation

You can execute in UDM/Pro/SE and UDR with:

```bash
curl -fsL "https://raw.githubusercontent.com/renedis/ubnt-auto-fan-speed/HEAD/on_boot.d/install.sh" | /bin/sh
```

This is a force to install script so will uninstall any previous version and install on_boot keeping your on boot files.

## What it does
It stops the build in service that monitors the thermal values, fan speed and connection of a HDD/SSD. After that it sets the thermal/fan chip (adt7475) to automatic mode. Once that is done it changes the thermal and fan threshold values specified in the script. If you like, you can change the values to your own preferences.
