#!/usr/bin/env python3
import sys

file = sys.argv[1]     
fd = open(file, 'r')    
content = fd.readline()    
print(content)         

fd.close()              
exit(0)