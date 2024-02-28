#!/bin/bash

fun_2() {
    let result=$1+$2
    result2=$(($1 + $2))
    echo 1-Le résultat de l\'addition est : $result
    echo 2-Le résultat de l\'addition est : $result2
}

fun_2 $1 $2