#!/bin/sh

#######################################################################
####################### FOR FIRMWARE 1.x.x ############################
#######################################################################

#######################################################################
######### Kill Ubuiquiti monitoring/fan-speed process first ###########
#######################################################################

if pidof ubnt-fan-speed &>/dev/null; then
  INIT_SCRIPT_PID=`pidof S04ubnt-fan-speed`
  UBNT_FAN_SPEED_PID=`pgrep -P ${INIT_SCRIPT_PID}`
  kill ${INIT_SCRIPT_PID} ${UBNT_FAN_SPEED_PID}
  sleep 1
fi

#######################################################################
################### Set fan mode to automatic mode ####################
#######################################################################
## 0 = OFF     (Fans runnning at full speed)
## 1 = MANUAL  (Fan speed will explicitly be set at own set values)
## 2 = AUTO    (Controller will adjust PWM duty cycle depending on temperature)
## This script does not check for a HDD/SSD, but you can adjust the HDD fan yourself.
#######################################################################

UBIOS_CPU_FAN_MODE=2
UBIOS_HDD_FAN_MODE=2

echo ${UBIOS_CPU_FAN_MODE} >/sys/class/hwmon/hwmon0/device/pwm2_enable
echo ${UBIOS_HDD_FAN_MODE} >/sys/class/hwmon/hwmon0/device/pwm1_enable

#######################################################################
########### Setting of fan speeds / PWM duty cycles ###################
################### Example: 60 x 0,392 = 23,53% ######################
#######################################################################
## Explained in a break-down:
## - 60 is the value set for the thermal chip
## - 0,392 is the value to calculate to percentage (this value is always the same)
## - 23,53% is the outcome value in percentage that the fan will run on
#######################################################################

UBIOS_CPU_MINIMAL_DUTY_FAN_PWM='60'        # default 128, this sets the minimal RPM for the CPU fan
UBIOS_HDD_MINIMAL_DUTY_FAN_PWM='0'         # default 128, this sets the minimal RPM for the HDD fan
UBIOS_CPU_MAXIMUM_DUTY_FAN_PWM='255'       # default 255, this sets the maximum RPM for the CPU fan
UBIOS_HDD_MAXIMUM_DUTY_FAN_PWM='255'       # default 255, this sets the maximum RPM for the HDD fan

echo ${UBIOS_CPU_MINIMAL_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm
echo ${UBIOS_HDD_MINIMAL_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm
echo ${UBIOS_CPU_MAXIMUM_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_pwm
echo ${UBIOS_HDD_MAXIMUM_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_pwm

#######################################################################
####################### Setting of temperatures #######################
################### 40000 equals 40 degree celsius ####################
#######################################################################

UBIOS_CPU_MINIMAL_TEMP='40000'       # default 45000, 45 degree celsius
UBIOS_HDD_MINIMAL_TEMP='40000'       # default 90000, 90 degree celsius
UBIOS_BRD_MINIMAL_TEMP='40000'       # default 90000, 90 degree celsius
UBIOS_CPU_MAXIMUM_TEMP='66000'       # default 72000, 72 degree celsius
UBIOS_HDD_MAXIMUM_TEMP='66000'       # default 112000, 112 degree celsius
UBIOS_BRD_MAXIMUM_TEMP='66000'       # default 112000, 112 degree celsius

echo ${UBIOS_CPU_MINIMAL_TEMP} >/sys/class/hwmon/hwmon0/device/temp1_auto_point1_temp
echo ${UBIOS_HDD_MINIMAL_TEMP} >/sys/class/hwmon/hwmon0/device/temp3_auto_point1_temp
echo ${UBIOS_BRD_MINIMAL_TEMP} >/sys/class/hwmon/hwmon0/device/temp2_auto_point1_temp
echo ${UBIOS_CPU_MAXIMUM_TEMP} >/sys/class/hwmon/hwmon0/device/temp1_auto_point2_temp
echo ${UBIOS_HDD_MAXIMUM_TEMP} >/sys/class/hwmon/hwmon0/device/temp3_auto_point2_temp
echo ${UBIOS_BRD_MAXIMUM_TEMP} >/sys/class/hwmon/hwmon0/device/temp2_auto_point2_temp
