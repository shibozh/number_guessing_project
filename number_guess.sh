#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
echo -e "\n~~~~ Guessing Number Game~~~~\n"
echo -e "\nEnter your username:"
read USERNAME
SEARCH_RESULT=$($PSQL "SELECT * FROM records WHERE username='$USERNAME'")
if [[ -z $SEARCH_RESULT ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_NEW_PLAYER=$($PSQL "INSERT INTO records(username) VALUES('$USERNAME')")
else
  IFS='|' read PLAYER_ID USERNAME GAMES_PLAYED BEST_GAME <<< "$SEARCH_RESULT"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# 生成随机数
RANDOM_NUMBER=$(( ( RANDOM % 1000 ) + 1 ))