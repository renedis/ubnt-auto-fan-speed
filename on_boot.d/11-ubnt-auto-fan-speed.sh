#!/bin/sh

##########
## 
## MODE CONFIG FOR AUTOMATIC FAN CONTROL
##
##  0 = OFF     (Fans runnning at full speed)
##  1 = MANUAL  (Fan speed will explicitly be set)
##  2 = AUTO    (Controller will adjust PWM duty cycle depending on temperature)
##
##########

#######################################################
######### CONFIRMED WORKING ON FIRMWARE 1.8.5 #########
## Kill Ubuiquiti monitoring/fan-speed process first ##
#######################################################

if pidof ubnt-fan-speed &>/dev/null; then
  INIT_SCRIPT_PID=`pidof S04ubnt-fan-speed`
  UBNT_FAN_SPEED_PID=`pgrep -P ${INIT_SCRIPT_PID}`
  kill ${INIT_SCRIPT_PID} ${UBNT_FAN_SPEED_PID}
  sleep 1
fi

###############################
## Set fan mode to automatic ##
###############################

UBIOS_CPU_FAN_MODE=2
UBIOS_HDD_FAN_MODE=2

echo ${UBIOS_CPU_FAN_MODE} >/sys/class/hwmon/hwmon0/device/pwm2_enable
echo ${UBIOS_HDD_FAN_MODE} >/sys/class/hwmon/hwmon0/device/pwm1_enable


##########################
##########################
#### CONFIG VARIABLES ####
##########################
##########################


####################################################################
## Setting of fan speeds / PWM duty cycles #########################
## Value of environment variable = 2.56 x intended Duty Cycle [%] ##
####################################################################

UBIOS_CPU_MINIMAL_DUTY_FAN_PWM='60'        # default 128, 106 = 2.400 rpm
UBIOS_HDD_MINIMAL_DUTY_FAN_PWM='0'         # default 128, 70 = 1.950 rpm
UBIOS_CPU_MAXIMUM_DUTY_FAN_PWM='255'       # default 255
UBIOS_HDD_MAXIMUM_DUTY_FAN_PWM='255'       # default 255

# Setting minimal CPU fan duty
echo ${UBIOS_CPU_MINIMAL_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm2_auto_point1_pwm

# Setting minimal HDD fan duty
echo ${UBIOS_HDD_MINIMAL_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm1_auto_point1_pwm

# Setting maximum CPU fan duty
echo ${UBIOS_CPU_MAXIMUM_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm2_auto_point2_pwm

# Setting maximum HDD fan duty
echo ${UBIOS_HDD_MAXIMUM_DUTY_FAN_PWM} >/sys/class/hwmon/hwmon0/device/pwm1_auto_point2_pwm

#############################
## Setting of temperatures ##
#############################

UBIOS_CPU_MINIMAL_TEMP='40000'       # default 45000
UBIOS_HDD_MINIMAL_TEMP='40000'       # default 90000
UBIOS_BRD_MINIMAL_TEMP='40000'       # default 90000
UBIOS_CPU_MAXIMUM_TEMP='66000'       # default 72000
UBIOS_HDD_MAXIMUM_TEMP='66000'       # default 112000
UBIOS_BRD_MAXIMUM_TEMP='66000'       # default 112000

# Setting minimal CPU temp
echo ${UBIOS_CPU_MINIMAL_TEMP} >/sys/class/hwmon/hwmon0/device/temp1_auto_point1_temp

# Setting minimal HDD temp
echo ${UBIOS_HDD_MINIMAL_TEMP} >/sys/class/hwmon/hwmon0/device/temp3_auto_point1_temp

# Setting minimal BOARD temp
echo ${UBIOS_BRD_MINIMAL_TEMP} >/sys/class/hwmon/hwmon0/device/temp2_auto_point1_temp

# Setting maximum CPU temp
echo ${UBIOS_CPU_MAXIMUM_TEMP} >/sys/class/hwmon/hwmon0/device/temp1_auto_point2_temp

# Setting maximum HDD temp
echo ${UBIOS_HDD_MAXIMUM_TEMP} >/sys/class/hwmon/hwmon0/device/temp3_auto_point2_temp

# Setting maximum BOARD temp
echo ${UBIOS_BRD_MAXIMUM_TEMP} >/sys/class/hwmon/hwmon0/device/temp2_auto_point2_temp
