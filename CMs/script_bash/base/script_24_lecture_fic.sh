#!/bin/bash
list=$(cat toto.txt)
for element in $list
do
  echo $element >> ./nouveau_toto.txt
done
