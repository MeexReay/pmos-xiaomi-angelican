#!/bin/sh

PMCONFIG=$(pmbootstrap config)
if [ -z "$PMAPORTS" ]; then export PMAPORTS=$(echo "$PMCONFIG" | sed -n 's/^aports = //p'); fi
if [ -z "$PMWORK" ]; then export PMWORK=$(echo "$PMCONFIG" | sed -n 's/^work = //p'); fi
