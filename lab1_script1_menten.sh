#!/bin/bash

# Matthew Menten - CSCI 4113 Spring 2019 - Lab 1

usage=$(df / | tail -1 | awk '{print $5}')
usage=${usage::-1}

#echo $usage

usage_boot=$(df /boot | tail -1 | awk '{print $5}')
usage_boot=${usage_boot::-1}

#echo $usage_boot

if [ $usage -gt 80 ]
then
    #echo usage of / above threshold
    mail -s "Usage of / Above Threshold" root@localhost <<< \
    'The filesystem at / has exceeded the usage threshold of 80%.'
fi

if [ $usage_boot -gt 80 ]
then
    #echo usage of /boot above threshold
    mail -s "Usage of /boot Above Threshold" root@localhost <<< \
    'The filesystem at /boot has exceeded the usage threshold of 80%.'
fi

