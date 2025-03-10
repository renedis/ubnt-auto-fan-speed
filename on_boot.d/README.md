## WARNING

USE THIS ON YOUR OWN RISK.
If you apply inappropriate settings with this script, you will possibly (soft- or hard-) brick your equipment.

# Scripted Installation

You can execute in UDM/Pro/SE and UDR with:

```bash
curl -fsL "https://raw.githubusercontent.com/renedis/ubnt-auto-fan-speed/HEAD/on_boot.d/install.sh" | /bin/sh
```

This is a force to install script so will uninstall any previous version and install on_boot keeping your on boot files.


# Manual Installation
## Firmware 2.x.x, 3.x.x and for UDM Pro (SE/Max) EA 4.x.x

### Installation

* Install [on_boot.d](https://github.com/boostchicken/udm-utilities)
* Via SSH; install fancontrol (apt install fancontrol) with default settings
* make a config file on "/etc/fancontrol" (vi /etc/fancontrol)
* restart the fancontrol service (sudo service fancontrol restart)

### Notes:

* This is tested on a UDM-Pro with firmware 2.5.16 and UDM-Pro SE with firmware 3.0.18. Not tested on a UDM or UDR.
* The UDM-Pro has 2 fans. A CPU fan (PWM2) and HDD fan (PWM1). The UDM-SE probably has an extra fan (not sure).
* When "sensors" is used;

- PWM1/TEMP3/FAN1 = Disk fan
- PWM2/TEMP1/FAN2 = CPU fan



Example sensors output:

```# sensors
adt7475-i2c-4-2e
Adapter: i2c-0-mux (chan_id 3)
in1:         891.00 mV (min =  +0.00 V, max =  +2.99 V)
+3.3V:         3.27 V  (min =  +2.96 V, max =  +3.63 V)
fan1:           0 RPM  (min =    0 RPM)
fan2:         819 RPM  (min =    0 RPM)
fan3:           0 RPM  (min =    0 RPM)
fan4:           0 RPM  (min =    0 RPM)
temp1:        +42.2°C  (low  = -63.0°C, high = +191.0°C)
                       (crit = +100.0°C, hyst = +96.0°C)
Board Temp:   +39.5°C  (low  = -63.0°C, high = +191.0°C)
                       (crit = +100.0°C, hyst = +96.0°C)
temp3:        +40.0°C  (low  = -63.0°C, high = +191.0°C)
                       (crit = +100.0°C, hyst = +96.0°C)
```

## Firmware 1.x.x

### Installation

* Install [on_boot.d](https://github.com/boostchicken/udm-utilities)
* Copy [`on_boot.d/11-ubnt-auto-fan-speed.sh`](https://github.com/renedis/ubnt-auto-fan-speed/raw/main/on_boot.d/11-ubnt-auto-fan-speed.sh) to your UDM (Pro) in `/mnt/data/on_boot.d`
* `chmod +x /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`
* Adjust the settings if you want (or use mine)
* Run the script: `sh /mnt/data/on_boot.d/11-ubnt-auto-fan-speed.sh`

It will survive a reboot thanks to @boostchicken 's bootscript. The OLED screen does show correct percentage and RPM. But it does not respond to changes anymore (the "slide" trick).
