#!/bin/bash

cpt=1
while read LINE
do
  echo $cpt ": " $LINE
  let cpt++
done < toto.txt
