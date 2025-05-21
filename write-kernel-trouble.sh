#!/bin/bash

tail -n 100 /tmp/full-kernel-trouble.txt > kernel-trouble.txt

less +G /tmp/full-kernel-trouble.txt

echo "Saved last 100 lines to \"$PWD/kernel-trouble.txt\""
echo "Full log was saved to \"/tmp/full-kernel-trouble.txt\""
