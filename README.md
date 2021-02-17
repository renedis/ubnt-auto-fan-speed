# ubnt-auto-fan-speed
Automatic fan speed setting on UDM-PRO 1.8.5+ firmware to make it silenced.


## WARNING
USE THIS ON YOUR OWN RISK.

If you apply inappropriate settings with this script, you will possibly (soft- or hard-) brick your equipment.


````
#
# manual setting of fan speeds / PWM duty cycles
# Value of environment variable = 2.56 x intended Duty Cycle [%]
#

UBIOS_CPU_MANUAL_FAN_PWM='128'  # 50% duty cycle
UBIOS_HDD_MANUAL_FAN_PWM='128'. # 50% duty cycle
````

## What it does

It stops the build in service that monitors the thermal values, fan speed and connection of a HDD/SSD. After that it sets the value of the thermal/fan chip (adt7475) to automatic mode. Once that's done it changes the values of the thermal/fan chip to lower ones. Or, if you like, you can set it up to your own specifications in the script.

## Installation

* Install [on_boot.d](https://github.com/boostchicken/udm-utilities)
* Copy [`on_boot.d/11-ubnt-auto-fan-speed.sh`](https://github.com/renedis/ubnt-auto-fan-speed/raw/main/on_boot.d/11-ubnt-auto-fan-speed.sh) to your UDM (Pro) in `/mnt/data/on_boot.d`
* `chmod +x /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`
* Adjust the settings if you want (or use mine)
* Run the script: `sh /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`

It will survive a reboot thanks to @boostchicken 's bootscript.
