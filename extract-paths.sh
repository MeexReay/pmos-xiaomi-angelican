#!/bin/sh

export PMAPORTS=$(pmbootstrap config | sed -n 's/^aports = //p')
export PMWORK=$(pmbootstrap config | sed -n 's/^work = //p')
