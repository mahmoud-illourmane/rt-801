#!/bin/bash

list=$(ls)
for element in $list
do
  echo $element >> ./toto.txt
done
