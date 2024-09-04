#!/bin/bash

PSQL=" psql --username=freecodecamp --dbname=periodic_table -t -c"
function getValsFromAtomicNumber() {
  ATOMIC_NUMBER=$($PSQL "select elements.atomic_number from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.ATOMIC_NUMBER=$1")
  SYMBOL=$($PSQL "select  symbol from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.ATOMIC_NUMBER=$1;")
  TYPE=$($PSQL "select types.type from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.ATOMIC_NUMBER=$1;")
  ATOMIC_MASS=$($PSQL "select atomic_mass from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.ATOMIC_NUMBER=$1;")
  NAME=$($PSQL "select  name from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.ATOMIC_NUMBER=$1;")
  MELTING_POINT=$($PSQL "select melting_point_celsius from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.ATOMIC_NUMBER=$1;")
  BOILING_POINT=$($PSQL "select boiling_point_celsius from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.ATOMIC_NUMBER=$1;")
}

function getValsFromSymbol() {
  ATOMIC_NUMBER=$($PSQL "select elements.atomic_number from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1'")
  SYMBOL=$($PSQL "select  symbol from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1';")
  TYPE=$($PSQL "select types.type from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1';")
  ATOMIC_MASS=$($PSQL "select atomic_mass from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1';")
  NAME=$($PSQL "select  name from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1';")
  MELTING_POINT=$($PSQL "select melting_point_celsius from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1';")
  BOILING_POINT=$($PSQL "select boiling_point_celsius from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1';")
}
function getValsFromName() {
  ATOMIC_NUMBER=$($PSQL "select atomic_number from elements WHERE elements.Name='$1'")
  SYMBOL=$($PSQL "select  symbol from elements WHERE elements.Name='$1';")
  NAME=$($PSQL "select  name from elements WHERE elements.Name='$1';")
  TYPE=$($PSQL "select types.type from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.Name='$1';")
  ATOMIC_MASS=$($PSQL "select atomic_mass from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.Name='$1';")
  MELTING_POINT=$($PSQL "select melting_point_celsius from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.Name='$1';")
  BOILING_POINT=$($PSQL "select boiling_point_celsius from elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number FULL JOIN types ON properties.type_id = types.type_id WHERE elements.Name='$1';")
}
ATOMIC_NUMBER='x'
if [[ $# = 0 ]]
# no arguments
then
  echo "Please provide an element as an argument."
elif [[ $# = 1 ]]
then
 # if a number
  if [[ $1 =~ ^[0-9]+$ ]]
    then
      getValsFromAtomicNumber $1
    # if the symbol
    elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
    then
      getValsFromSymbol $1
    elif [[ $1 =~ ^[A-Za-z]+$ ]]
    then
      getValsFromName $1
  fi
  
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    echo "The element with atomic number ${ATOMIC_NUMBER// /} is ${NAME// /} (${SYMBOL// /}). It's a ${TYPE// /}, with a mass of ${ATOMIC_MASS// /} amu. ${NAME// /} has a melting point of ${MELTING_POINT// /} celsius and a boiling point of ${BOILING_POINT// /} celsius."
  fi
fi

