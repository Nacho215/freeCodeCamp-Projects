#!/bin/bash

#PSQL command
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#If run without arguments
if [[ -z $1 ]]
then
  #Print message and quit
  echo "Please provide an element as an argument."
  exit
else
  # If argument is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    #Get the element with that atomic_number
    ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, t.type, p.atomic_mass, p.melting_point_celsius, \
    p.boiling_point_celsius FROM elements AS e JOIN properties AS p USING(atomic_number) JOIN types AS t USING(type_id) \
    WHERE e.atomic_number = $1;")
  #If is not a number
  else
    #Get the element with that name or symbol
    ELEMENT_INFO=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, t.type, p.atomic_mass, p.melting_point_celsius, \
    p.boiling_point_celsius FROM elements AS e JOIN properties AS p USING(atomic_number) JOIN types AS t USING(type_id) \
    WHERE name = '$1' OR symbol = '$1';")
  fi
  #If can't find the element
  if [[ -z $ELEMENT_INFO ]]
  then
    #Print message
    echo "I could not find that element in the database."
  else
    #If find the element, print the its information
    echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELT_POINT BAR BOIL_POINT
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu." \
      "$NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
    done
  fi
fi