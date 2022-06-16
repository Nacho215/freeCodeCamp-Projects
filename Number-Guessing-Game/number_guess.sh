#!/bin/bash

#PSQL command
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

#Random number between 1 and 1000
SECRET_NUMBER=$((1 + $RANDOM % 1000))

#Number of guesses
NUMBER_OF_GUESSES=0

MAIN_MENU(){
  #Ask user for a name
  echo "Enter your username:"
  read USERNAME
  #See if user is loaded in the database
  USER_IN_DATABASE=$($PSQL "SELECT user_id, name FROM users WHERE name = '$USERNAME';")
  #If can't find the user
  if [[ -z $USER_IN_DATABASE ]]
  then
    #Welcome message
    echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  else
    #If user is in database, print his stats
    USER_INFO=$($PSQL "SELECT u.name, COUNT(g.user_id) as games, MIN(g.number_of_guesses) as best_game FROM games as g JOIN users AS u USING(user_id) WHERE u.name = '$USERNAME' GROUP BY u.name;")
    echo "$USER_INFO" | while read NAME BAR GAMES BAR BEST_GAME 
    do
      echo -e "Welcome back, $NAME! You have played $GAMES games, and your best game took $BEST_GAME guesses."
    done
  fi
  #Play the game
  PLAY_GAME "Guess the secret number between 1 and 1000:"
}

PLAY_GAME(){
  #Increment the number of guesses
  (( NUMBER_OF_GUESSES++ ))
  #Print the argument message
  echo $1
  #Read the user guess
  read GUESS
  #If is not an integer, print message and guess again
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    PLAY_GAME "That is not an integer, guess again:"
  else
    #Print to user if his guess is lower or higher than the secret number, and guess again
    if [[ $GUESS < $SECRET_NUMBER ]]
    then
      PLAY_GAME "It's higher than that, guess again:"
    elif [[ $GUESS > $SECRET_NUMBER ]]
    then
      PLAY_GAME "It's lower than that, guess again:"
    #If user guess the number
    else
      #If user is not in the database
      if [[ -z $USER_IN_DATABASE ]]
      then
        #Add user into the database
        ADD_USER=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME');")
        #If adding successfully
        if [[ $ADD_USER == "INSERT 0 1" ]]
        then
          #Save the game
          SAVE_GAME
        fi
      #If user is already in the database
      else
        #Save the game
        SAVE_GAME
      fi
    fi
  fi
}

SAVE_GAME(){
  #Get user id
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME';")
  #Add the game played into the database
  ADD_GAME=$($PSQL "INSERT INTO games(user_id, number_of_guesses) VALUES($USER_ID, $NUMBER_OF_GUESSES);")
  #If adding is successfully
  if [[ $ADD_GAME == "INSERT 0 1" ]]
  then
	#Print winning message
    echo -e "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi
}

#Starts in main menu
MAIN_MENU
