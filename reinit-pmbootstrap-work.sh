#!/bin/bash

source extract-paths.sh
pmbootstrap -y zap
pmbootstrap shutdown
sudo rm -rf $PMWORK

python3 - <<'EOF'
import subprocess, time, os

proc = subprocess.Popen(
  ["pmbootstrap", "init"],
  stdin=subprocess.PIPE,
  stdout=subprocess.PIPE,
  stderr=subprocess.STDOUT,
  text=True,
  bufsize=1
)

def skip_question(wait_for=""):
  while wait_for not in proc.stdout.readline():
    time.sleep(0.1)
  proc.stdin.write("\n")
  proc.stdin.flush()

skip_question()

os.system(f"git clone https://gitlab.postmarketos.org/postmarketOS/pmaports.git {os.environ['PMAPORTS']}")

skip_question()

os.system(f"ln -s {os.environ['PWD']}/linux-xiaomi-angelican {os.environ['PMAPORTS']}/device/testing")
os.system(f"ln -s {os.environ['PWD']}/device-xiaomi-angelican {os.environ['PMAPORTS']}/device/testing")

skip_question("Channel")

for _ in range(4):
  skip_question()

skip_question("User interface")

for _ in range(9):
  skip_question()

proc.wait()
EOF
