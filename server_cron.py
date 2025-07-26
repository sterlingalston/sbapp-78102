#!/usr/bin/env python3
import subprocess
import os

# Change to /var/log directory and start HTTP server
os.chdir('/var/log')
subprocess.run(['python3', '-m', 'http.server', '8000'])
