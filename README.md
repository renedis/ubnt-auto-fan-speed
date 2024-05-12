# ubnt-auto-fan-speed
Automatic fan speed setting on UDM-PRO (including SE) 1.12.38 release firmware to make it silenced. Also working on 2.x.x, 3.x.x and 4.x.x!


## WARNING
USE THIS ON YOUR OWN RISK.
If you apply inappropriate settings with this script, you will possibly (soft- or hard-) brick your equipment.



## What it does
It stops the build in service that monitors the thermal values, fan speed and connection of a HDD/SSD. After that it sets the thermal/fan chip (adt7475) to automatic mode. Once that is done it changes the thermal and fan threshold values specified in the script. If you like, you can change the values to your own preferences.
