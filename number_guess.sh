#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
echo -e "\n~~~~ Guessing Number Game~~~~\n"
echo -e "\nEnter your username:"
read USERNAME
USERNAME=$(echo "$USERNAME" | sed -r 's/^ *| *$//g')
SEARCH_RESULT=$($PSQL "SELECT * FROM records WHERE username='$USERNAME'")
if [[ -z $SEARCH_RESULT ]]
then
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  INSERT_NEW_PLAYER=$($PSQL "INSERT INTO records(username) VALUES('$USERNAME')")
else
  IFS='|' read PLAYER_ID USERNAME GAMES_PLAYED BEST_GAME <<< "$SEARCH_RESULT"
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# 生成随机数
RANDOM_NUMBER=$(( ( RANDOM % 1000 ) + 1 ))
echo -e "\nGuess the secret number between 1 and 1000:"
echo $RANDOM_NUMBER
GUESS_TIME=0
while true
do
  read PLAYER_GUESS
  if [[ $PLAYER_GUESS =~ ^[0-9]+$ ]]
  then
    GUESS_TIME=$((GUESS_TIME + 1))
    if [[ $PLAYER_GUESS -lt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
      continue
    elif [[ $PLAYER_GUESS -gt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"
      continue
    else
      echo -e "\nYou guessed it in $GUESS_TIME tries. The secret number was $RANDOM_NUMBER. Nice job!"
      GAME_PLAYED=$($PSQL "SELECT games_played FROM records WHERE username='$USERNAME'")
      GAME_PLAYED=$((GAME_PLAYED + 1))
      UPDATE_GAME_PLAYED=$($PSQL "UPDATE records SET games_played = $GAME_PLAYED WHERE username='$USERNAME'")


      BEST_GAME=$($PSQL "SELECT best_game FROM records WHERE username='$USERNAME'")
      if [[ -z $BEST_GAME ]] || [[ $GUESS_TIME -lt $BEST_GAME ]]; then
        UPDATE_BEST_GAME=$($PSQL "UPDATE records SET best_game = $GUESS_TIME WHERE username='$USERNAME'")
      fi
      break
    fi
  else
    echo -e "\nThat is not an integer, guess again:"
  fi
done