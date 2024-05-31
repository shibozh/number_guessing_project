#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
echo -e "\n~~~~ Guessing Number Game~~~~\n"
echo -e "\nEnter your username:"
read USERNAME
SEARCH_RESULT=$($PSQL "SELECT * FROM records WHERE name='$USERNAME'")
if [[ -z $SEARCH_RESULT ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  echo $SEARCH_RESULT | while IFS='|' read PLAYER_ID NAME GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi