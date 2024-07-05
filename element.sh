#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
#Check if argument 1 is empty
if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  #Check if input is integer
  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$1
    #Check if input matches atomic number
    QUERY_ATOMIC_NUMBER_RESULT=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    #If input doesn't match atomic number
    if [[ -z $QUERY_ATOMIC_NUMBER_RESULT ]]
    then
      echo -e "I could not find that element in the database."
    else
      #Upon match, return element details using atomic number
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING (type_id) WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    fi
  else
    #Check if input matches symbol
    QUERY_ELEMENT_SYMBOL_RESULT=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
    #If input doesn't match symbol
    if [[ -z $QUERY_ELEMENT_SYMBOL_RESULT ]]
    then
      #Check if input matches name
      QUERY_ELEMENT_NAME_RESULT=$($PSQL "SELECT name FROM elements WHERE name='$1'")
      #If input doesn't match name
      if [[ -z $QUERY_ELEMENT_NAME_RESULT ]]
      then
        echo -e "I could not find that element in the database."
      else
        #Upon match, return element details using name
        ELEMENT_NAME=$1
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$ELEMENT_NAME'")
        ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$ELEMENT_NAME'")
        ELEMENT_TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING (type_id) WHERE atomic_number=$ATOMIC_NUMBER")
        ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
        ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
        ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
        echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
      fi
    else
      #Upon match, return element details using symbol
      ELEMENT_SYMBOL=$1
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT_SYMBOL'")
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$ELEMENT_SYMBOL'")
      ELEMENT_TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING (type_id) WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    fi
  fi
fi