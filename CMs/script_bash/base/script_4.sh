#!/bin/bash
var1=0
echo $var1
let var1++
echo $var1

var2=45
var3=$(($var2+345))
echo $var3

var4=45
var5=$[$var2+347]
echo $var5