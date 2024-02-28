#!/usr/bin/env python3
import subprocess

p = subprocess.Popen(["ls", "-al"], stdout=subprocess.PIPE)
print(p.communicate())
exit(0)