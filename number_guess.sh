#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
echo -e "\n~~~~ Guessing Number Game~~~~\n"
echo -e "\nEnter your username:"
read USERNAME
USERNAME=$(echo "$USERNAME" | sed -r 's/^ *| *$//g')

if [[ -z "$USERNAME" ]]; then
  echo "Username cannot be empty. Please run the script again and enter a valid username."
  exit 1
fi

SEARCH_RESULT=$($PSQL "SELECT player_id, username, games_played, best_game FROM records WHERE username='$USERNAME'")
if [[ $SEARCH_RESULT ]]
then
  IFS='|' read PLAYER_ID USERNAME GAMES_PLAYED BEST_GAME <<< "$SEARCH_RESULT"
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  INSERT_NEW_PLAYER=$($PSQL "INSERT INTO records(username, games_played, best_game) VALUES('$USERNAME', 0, NULL)")
  GAMES_PLAYED=0
  BEST_GAME=NULL
fi

RANDOM_NUMBER=$(( ( RANDOM % 1000 ) + 1 ))
echo -e "\nGuess the secret number between 1 and 1000:"
GUESS_TIME=0

while true
do
  read PLAYER_GUESS
  if [[ $PLAYER_GUESS =~ ^[0-9]+$ ]]
  then
    GUESS_TIME=$((GUESS_TIME + 1))
    if [[ $PLAYER_GUESS -lt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"
    elif [[ $PLAYER_GUESS -gt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
    else
      GAMES_PLAYED=$((GAMES_PLAYED + 1))
      UPDATE_GAME_PLAYED=$($PSQL "UPDATE records SET games_played = $GAMES_PLAYED WHERE username='$USERNAME'")

      if [[ $BEST_GAME == "NULL" ]] || [[ $GUESS_TIME -lt $BEST_GAME ]]; then
        UPDATE_BEST_GAME=$($PSQL "UPDATE records SET best_game = $GUESS_TIME WHERE username='$USERNAME'")
      fi

      echo -e "\nYou guessed it in $GUESS_TIME tries. The secret number was $RANDOM_NUMBER. Nice job!"
      break
    fi
  else
    echo -e "\nThat is not an integer, guess again:"
  fi
done