## WARNING
USE THIS ON YOUR OWN RISK.
If you apply inappropriate settings with this script, you will possibly (soft- or hard-) brick your equipment.

# Firmware 1.x.x
## Installation
* Install [on_boot.d](https://github.com/boostchicken/udm-utilities)
* Copy [`on_boot.d/11-ubnt-auto-fan-speed.sh`](https://github.com/renedis/ubnt-auto-fan-speed/raw/main/on_boot.d/11-ubnt-auto-fan-speed.sh) to your UDM (Pro) in `/mnt/data/on_boot.d`
* `chmod +x /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`
* Adjust the settings if you want (or use mine)
* Run the script: `sh /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`

It will survive a reboot thanks to @boostchicken 's bootscript. The OLED screen does show correct percentage and RPM. But it does not respond to changes anymore (the "slide" trick).


# Firmware 2.x.x (and maybe 3.x.x? = not tested)
##Installation
* Install [on_boot.d](https://github.com/boostchicken/udm-utilities)
* Via SSH; install fancontrol (apt install fancontrol) with default settings
* make a config file on "/etc/fancontrol" (vi /etc/fancontrol)
* restart the fancontrol service (sudo service fancontrol restart)

#Notes:
* This is tested on a UDM-Pro with firmware 2.4.27. Not tested on a UDM-SE, UDM or UDR.
* The UDM-Pro has 2 fans. A CPU fan (PWM1) and HDD fan (PWM2). The UDM-SE probably has an extra fan (not sure).
* Whe "sensors" is used;
- FAN1 = HDD-fan
- FAN2 + FAN3 + FAN4 = CPU-fan
