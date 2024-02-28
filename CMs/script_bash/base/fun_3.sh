#!/bin/bash

convertirCelsiusEnFahrenheit() {
  echo "En Fahrenheit, cela fait : $((($1 * 9/5) + 32))°F"
}

echo "Entrez la température en Celsius :"
read celsius

convertirCelsiusEnFahrenheit $celsius
